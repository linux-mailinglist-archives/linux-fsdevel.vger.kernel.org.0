Return-Path: <linux-fsdevel+bounces-59405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1DB38775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3366B17F1DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE77345732;
	Wed, 27 Aug 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5lLe0Ex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E935335BBB;
	Wed, 27 Aug 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310971; cv=none; b=Yylw7d6Ma1Bs7ijqOH5Wxw59KYDo35RSOW0+tfrPrs0FRnDawmcENhRQT8wx1bQE4LHxiKstW5wiVGtJ8rVXrRTvrmTUJp0amMve3ZyF3LLBz2JtPjXCMIhf6VZthJSAxYCl5b1SHM5fg1ZvrXlrwglsGe797WO3LsRMQw7CJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310971; c=relaxed/simple;
	bh=3nnatlP1fBqIs79HM6dGWG8y2mvb98rMjnvORo80/yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAs5GSR9mAUDs7hYZbEJYauwrpfzu1Cp36e3Yr2i5OCJ9UaFvUU6lhWEUPCRRIjnpJFmDJ+QQy3cRY7QHZbiSxNnvbk3EF+0gWqsr+iqqYNoEDC8l97/01ruJ2KqLpyJUCig7DDWG52KupJWoBhzZlyCBEEa22YIZNmbrMn81tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5lLe0Ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9A3C4CEEB;
	Wed, 27 Aug 2025 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310970;
	bh=3nnatlP1fBqIs79HM6dGWG8y2mvb98rMjnvORo80/yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5lLe0ExCpNJcx9HD9+tHMs62ZPzPN3LolGxkVKXQbJnWWS+XfzG94xy9mOVxPclM
	 HQqAMveFN9XExZ9p3AIDq5sozf2Mevy/+VgZCxtSXnT8dyZkUPdQeh3rcfaFPDDHT1
	 7ibnZyK5damlUHv89OJckYLCakpe9guaEu4LhezAyhUbzAoMKc/LiBX9tKs8FjJvAz
	 9kuKy4W92TU3RwtW2EdAwMyeGaDaAa3/EC+nzWHggFCfTPlV60caTOuJcKLUE0m2u1
	 5U1U/9H6NeSG14yeaNvQF81XaoiqOODVhsJLWqSQ6inXoG2eFEw4vSQpgB82wSex/8
	 tGDmSFT0+OMVw==
Date: Wed, 27 Aug 2025 12:09:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, Jan Kara <jack@suse.com>,
	Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <aK8tuTnuHbD8VOyo@kernel.org>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
 <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
 <aKx485EMthHfBWef@kbusch-mbp>
 <87cy8ir835.fsf@gmail.com>
 <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>

Hi Jan,

On Wed, Aug 27, 2025 at 05:20:53PM +0200, Jan Kara wrote:
> On Tue 26-08-25 10:29:58, Ritesh Harjani wrote:
> > Keith Busch <kbusch@kernel.org> writes:
> > 
> > > On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
> > >> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
> > >> > Keith Busch <kbusch@meta.com> writes:
> > >> > >
> > >> > >   - EXT4 falls back to buffered io for writes but not for reads.
> > >> > 
> > >> > ++linux-ext4 to get any historical context behind why the difference of
> > >> > behaviour in reads v/s writes for EXT4 DIO. 
> > >> 
> > >> Hum, how did you test? Because in the basic testing I did (with vanilla
> > >> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
> > >> falling back to buffered IO only if the underlying file itself does not
> > >> support any kind of direct IO.
> > >
> > > Simple test case (dio-offset-test.c) below.
> > >
> > > I also ran this on vanilla kernel and got these results:
> > >
> > >   # mkfs.ext4 /dev/vda
> > >   # mount /dev/vda /mnt/ext4/
> > >   # make dio-offset-test
> > >   # ./dio-offset-test /mnt/ext4/foobar
> > >   write: Success
> > >   read: Invalid argument
> > >
> > > I tracked the "write: Success" down to ext4's handling for the "special"
> > > -ENOTBLK error after ext4_want_directio_fallback() returns "true".
> > >
> > 
> > Right. Ext4 has fallback only for dio writes but not for DIO reads... 
> > 
> > buffered
> > static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> > {
> > 	/* must be a directio to fall back to buffered */
> > 	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> > 		    (IOMAP_WRITE | IOMAP_DIRECT))
> > 		return false;
> > 
> >     ...
> > }
> > 
> > So basically the path is ext4_file_[read|write]_iter() -> iomap_dio_rw
> >     -> iomap_dio_bio_iter() -> return -EINVAL. i.e. from...
> > 
> > 
> > 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> > 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > 		return -EINVAL;
> > 
> > EXT4 then fallsback to buffered-io only for writes, but not for reads. 
> 
> Right. And the fallback for writes was actually inadvertedly "added" by
> commit bc264fea0f6f "iomap: support incremental iomap_iter advances". That
> changed the error handling logic. Previously if iomap_dio_bio_iter()
> returned EINVAL, it got propagated to userspace regardless of what
> ->iomap_end() returned. After this commit if ->iomap_end() returns error
> (which is ENOTBLK in ext4 case), it gets propagated to userspace instead of
> the error returned by iomap_dio_bio_iter().
> 
> Now both the old and new behavior make some sense so I won't argue that the
> new iomap_iter() behavior is wrong. But I think we should change ext4 back
> to the old behavior of failing unaligned dio writes instead of them falling
> back to buffered IO. I think something like the attached patch should do
> the trick - it makes unaligned dio writes fail again while writes to holes
> of indirect-block mapped files still correctly fall back to buffered IO.
> Once fstests run completes, I'll do a proper submission...
> 
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> From ce6da00a09647a03013c3f420c2e7ef7489c3de8 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Wed, 27 Aug 2025 14:55:19 +0200
> Subject: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
> 
> Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> changed the error handling logic in iomap_iter(). Previously any error
> from iomap_dio_bio_iter() got propagated to userspace, after this commit
> if ->iomap_end returns error, it gets propagated to userspace instead of
> an error from iomap_dio_bio_iter(). This results in unaligned writes to
> ext4 to silently fallback to buffered IO instead of erroring out.
> 
> Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
> unnecessary these days. It is enough to return ENOTBLK from
> ext4_iomap_begin() when we don't support DIO write for that particular
> file offset (due to hole).

Any particular reason for ext4 still returning -ENOTBLK for unaligned
DIO?

In my experience XFS returns -EINVAL when failing unaligned DIO (but
maybe there are edge cases where that isn't always the case?)

Would be nice to have consistency across filesystems for what is
returned when failing unaligned DIO.

The iomap code returns -ENOTBLK as "the magic error code to fall back
to buffered I/O".  But that seems only for page cache invalidation
failure, _not_ for unaligned DIO.

(Anyway, __iomap_dio_rw's WRITE handling can return -ENOTBLK if page
cache invalidation fails during DIO write. So it seems higher-level
code, like I've added to NFS/NFSD to check for unaligned DIO failure,
should check for both -EINVAL and -ENOTBLK).

Thanks,
Mike

ps. ENOTBLK is actually much less easily confused with other random
uses of EINVAL (EINVAL use is generally way too overloaded, rendering
it a pretty unhelpful error).  But switching XFS to use ENOTBLK
instead of EINVAL seems like disruptive interface breakage (I suppose
same could be said for ext4 if it were to now return EINVAL for
unaligned DIO, but ext4 flip-flopping on how it handles unaligned DIO
prompted me to ask these questions now)

> ---
>  fs/ext4/file.c  |  2 --
>  fs/ext4/inode.c | 35 -----------------------------------
>  2 files changed, 37 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 93240e35ee36..cf39f57d21e9 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -579,8 +579,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
> -	if (ret == -ENOTBLK)
> -		ret = 0;
>  	if (extend) {
>  		/*
>  		 * We always perform extending DIO write synchronously so by
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..c3b23c90fd11 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3872,47 +3872,12 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
>  	return ret;
>  }
>  
> -static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> -{
> -	/* must be a directio to fall back to buffered */
> -	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> -		    (IOMAP_WRITE | IOMAP_DIRECT))
> -		return false;
> -
> -	/* atomic writes are all-or-nothing */
> -	if (flags & IOMAP_ATOMIC)
> -		return false;
> -
> -	/* can only try again if we wrote nothing */
> -	return written == 0;
> -}
> -
> -static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> -			  ssize_t written, unsigned flags, struct iomap *iomap)
> -{
> -	/*
> -	 * Check to see whether an error occurred while writing out the data to
> -	 * the allocated blocks. If so, return the magic error code for
> -	 * non-atomic write so that we fallback to buffered I/O and attempt to
> -	 * complete the remainder of the I/O.
> -	 * For non-atomic writes, any blocks that may have been
> -	 * allocated in preparation for the direct I/O will be reused during
> -	 * buffered I/O. For atomic write, we never fallback to buffered-io.
> -	 */
> -	if (ext4_want_directio_fallback(flags, written))
> -		return -ENOTBLK;
> -
> -	return 0;
> -}
> -
>  const struct iomap_ops ext4_iomap_ops = {
>  	.iomap_begin		= ext4_iomap_begin,
> -	.iomap_end		= ext4_iomap_end,
>  };
>  
>  const struct iomap_ops ext4_iomap_overwrite_ops = {
>  	.iomap_begin		= ext4_iomap_overwrite_begin,
> -	.iomap_end		= ext4_iomap_end,
>  };
>  
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> -- 
> 2.43.0
> 


