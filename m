Return-Path: <linux-fsdevel+bounces-59990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A5B40742
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A008D5E2AC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FA2320A31;
	Tue,  2 Sep 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lo/1SL+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B622821255E;
	Tue,  2 Sep 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823948; cv=none; b=KPV3JkuTa+khgWb4jId6yfZV5VIPBmP+q7SLW7HP1KGtmd11E22UpqWnX1YrGYrvlXJmT9DJi3Bfncpu/U0p5PkRsxi6Ptmai6d8qtx59PcNjJ7bcR6M3OiklkyVvWSxT7uvpBCctByW0zfic5wSv0r9VlfPYO36g0M+9iU7SDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823948; c=relaxed/simple;
	bh=7olc+ixJY7yRJvVbu1KUegrla3LHsjblyKnh7iAz4QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQdcPtfYGmKkva8Fy2YZN8hYZeOPi1dqKVIAwsM9ifo1orNiRMGdIXWai2oFC7z7HS2sgxrdgW74Fy1+B49ZM0T41EgAVtAxAeuDy2cTkvuUJ5CZeeajED7bDirFjP8ZV9qrHTBMQ1z3P/n0W++e09el9uggeGhQE5wGbbm5nd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lo/1SL+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14537C4CEED;
	Tue,  2 Sep 2025 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823948;
	bh=7olc+ixJY7yRJvVbu1KUegrla3LHsjblyKnh7iAz4QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lo/1SL+qpwGqKqzEBfooY5BRf6NW9saWYqq5am5cfAOVdZQsfbbFuX/rjlE1U6aS+
	 iYh7x0D6qoJMv7LstQ1hOpt02jS32ahAVeabeJ+rlXYhAvr3FdA1sFgbbAN3+lUgQD
	 oqy23AcpQaHT4QD2Mz2H2zRN1eqCkA40ws48BAex7GW6cgFcvG/iE6uq8oVa0ZJREf
	 4EG9O7fzmB6fPvPgLH1MPYmEYHeCwDOaoqI+yg0Nf8qoyvM8WFWRb/GVJomIcGd0xn
	 lz8HkQ6aNO0ub3mzEjyjt1eA/pzMSQQxdhP73lf2UDkdRbWn5sbpoczVkDN9l2C3F7
	 82/V2j6iD+ayQ==
Date: Tue, 2 Sep 2025 10:39:06 -0400
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
Message-ID: <aLcBivUrXs0YZ-pq@kernel.org>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
 <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
 <aKx485EMthHfBWef@kbusch-mbp>
 <87cy8ir835.fsf@gmail.com>
 <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
 <aK8tuTnuHbD8VOyo@kernel.org>
 <pcmvk3tb3cre3dao2suskdxjrkk6q5z2olkgbkyqoaxujelokg@34hc5pudk3lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pcmvk3tb3cre3dao2suskdxjrkk6q5z2olkgbkyqoaxujelokg@34hc5pudk3lt>

On Mon, Sep 01, 2025 at 09:55:20AM +0200, Jan Kara wrote:
> Hi Mike!
> 
> On Wed 27-08-25 12:09:29, Mike Snitzer wrote:
> > On Wed, Aug 27, 2025 at 05:20:53PM +0200, Jan Kara wrote:
> > > On Tue 26-08-25 10:29:58, Ritesh Harjani wrote:
> > > > Keith Busch <kbusch@kernel.org> writes:
> > > > 
> > > > > On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
> > > > >> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
> > > > >> > Keith Busch <kbusch@meta.com> writes:
> > > > >> > >
> > > > >> > >   - EXT4 falls back to buffered io for writes but not for reads.
> > > > >> > 
> > > > >> > ++linux-ext4 to get any historical context behind why the difference of
> > > > >> > behaviour in reads v/s writes for EXT4 DIO. 
> > > > >> 
> > > > >> Hum, how did you test? Because in the basic testing I did (with vanilla
> > > > >> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
> > > > >> falling back to buffered IO only if the underlying file itself does not
> > > > >> support any kind of direct IO.
> > > > >
> > > > > Simple test case (dio-offset-test.c) below.
> > > > >
> > > > > I also ran this on vanilla kernel and got these results:
> > > > >
> > > > >   # mkfs.ext4 /dev/vda
> > > > >   # mount /dev/vda /mnt/ext4/
> > > > >   # make dio-offset-test
> > > > >   # ./dio-offset-test /mnt/ext4/foobar
> > > > >   write: Success
> > > > >   read: Invalid argument
> > > > >
> > > > > I tracked the "write: Success" down to ext4's handling for the "special"
> > > > > -ENOTBLK error after ext4_want_directio_fallback() returns "true".
> > > > >
> > > > 
> > > > Right. Ext4 has fallback only for dio writes but not for DIO reads... 
> > > > 
> > > > buffered
> > > > static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> > > > {
> > > > 	/* must be a directio to fall back to buffered */
> > > > 	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> > > > 		    (IOMAP_WRITE | IOMAP_DIRECT))
> > > > 		return false;
> > > > 
> > > >     ...
> > > > }
> > > > 
> > > > So basically the path is ext4_file_[read|write]_iter() -> iomap_dio_rw
> > > >     -> iomap_dio_bio_iter() -> return -EINVAL. i.e. from...
> > > > 
> > > > 
> > > > 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> > > > 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > > > 		return -EINVAL;
> > > > 
> > > > EXT4 then fallsback to buffered-io only for writes, but not for reads. 
> > > 
> > > Right. And the fallback for writes was actually inadvertedly "added" by
> > > commit bc264fea0f6f "iomap: support incremental iomap_iter advances". That
> > > changed the error handling logic. Previously if iomap_dio_bio_iter()
> > > returned EINVAL, it got propagated to userspace regardless of what
> > > ->iomap_end() returned. After this commit if ->iomap_end() returns error
> > > (which is ENOTBLK in ext4 case), it gets propagated to userspace instead of
> > > the error returned by iomap_dio_bio_iter().
> > > 
> > > Now both the old and new behavior make some sense so I won't argue that the
> > > new iomap_iter() behavior is wrong. But I think we should change ext4 back
> > > to the old behavior of failing unaligned dio writes instead of them falling
> > > back to buffered IO. I think something like the attached patch should do
> > > the trick - it makes unaligned dio writes fail again while writes to holes
> > > of indirect-block mapped files still correctly fall back to buffered IO.
> > > Once fstests run completes, I'll do a proper submission...
> > > 
> > > 
> > > 								Honza
> > > -- 
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> > 
> > > From ce6da00a09647a03013c3f420c2e7ef7489c3de8 Mon Sep 17 00:00:00 2001
> > > From: Jan Kara <jack@suse.cz>
> > > Date: Wed, 27 Aug 2025 14:55:19 +0200
> > > Subject: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
> > > 
> > > Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> > > changed the error handling logic in iomap_iter(). Previously any error
> > > from iomap_dio_bio_iter() got propagated to userspace, after this commit
> > > if ->iomap_end returns error, it gets propagated to userspace instead of
> > > an error from iomap_dio_bio_iter(). This results in unaligned writes to
> > > ext4 to silently fallback to buffered IO instead of erroring out.
> > > 
> > > Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
> > > unnecessary these days. It is enough to return ENOTBLK from
> > > ext4_iomap_begin() when we don't support DIO write for that particular
> > > file offset (due to hole).
> > 
> > Any particular reason for ext4 still returning -ENOTBLK for unaligned
> > DIO?
> 
> No, that is actually the bug I'm speaking about - ext4 should be returning
> EINVAL for unaligned DIO as other filesystems do but after recent iomap
> changes it started to return ENOTBLK.
> 
> > In my experience XFS returns -EINVAL when failing unaligned DIO (but
> > maybe there are edge cases where that isn't always the case?)
> > 
> > Would be nice to have consistency across filesystems for what is
> > returned when failing unaligned DIO.
> 
> Agreed although there are various corner cases like files which never
> support direct IO - e.g. with data journalling - and thus fallback to
> buffered IO happens before any alignment checks. 
> 
> > The iomap code returns -ENOTBLK as "the magic error code to fall back
> > to buffered I/O".  But that seems only for page cache invalidation
> > failure, _not_ for unaligned DIO.
> > 
> > (Anyway, __iomap_dio_rw's WRITE handling can return -ENOTBLK if page
> > cache invalidation fails during DIO write. So it seems higher-level
> > code, like I've added to NFS/NFSD to check for unaligned DIO failure,
> > should check for both -EINVAL and -ENOTBLK).
> 
> I think the idea here is that if page cache invalidation fails we want to
> fallback to buffered IO so that we don't cause cache coherency issues and
> that's why ENOTBLK is returned.
> 
> > ps. ENOTBLK is actually much less easily confused with other random
> > uses of EINVAL (EINVAL use is generally way too overloaded, rendering
> > it a pretty unhelpful error).  But switching XFS to use ENOTBLK
> > instead of EINVAL seems like disruptive interface breakage (I suppose
> > same could be said for ext4 if it were to now return EINVAL for
> > unaligned DIO, but ext4 flip-flopping on how it handles unaligned DIO
> > prompted me to ask these questions now)
> 
> Definitely. In this particular case EINVAL for unaligned DIO is there for
> ages and there likely is some userspace program somewhere that depends on
> it.

Thanks for your reply, that all makes sense.

Mike

