Return-Path: <linux-fsdevel+bounces-43322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FAA5455A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C8316ACD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859982080E5;
	Thu,  6 Mar 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ild6cuZq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002B207A05;
	Thu,  6 Mar 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251049; cv=none; b=gzn4cLbYB+wQe0XGSP5NRkUI9sggLvakwEKq6Qz9ZPEaF8qpG2XFUuvu7018xAcqZC50i/OxGBwdST0iZfqomI+IeI6dgg/RQ1cCwiuFtsjdin+oIAv1APONF9DP5Aw9cqwOiFMJkBGSV9mf5aXzcNzkJLQlg/YCcq1Yrj8p15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251049; c=relaxed/simple;
	bh=vKM1MMSoy2IDAm4XNuPTAz/yyPszNBX0fQkGrN6Ybm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxeIwYd3Vy2RAEUCfO8Z0DgZdkc/UInvABvwpcNNjSxlBmmvYy/aOLVwvQNX6RD/KBmvBnZZ1YK2PHXnPWh5h7bxYvAzN2YyJEJymbSPz/IqtoW+9TY4pN2xJLCcgJ7B3c7WqUMjKIQYRuHIOwfCLu/vDNeZIGRR6syBXxW6IrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ild6cuZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958FDC4CEE0;
	Thu,  6 Mar 2025 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741251049;
	bh=vKM1MMSoy2IDAm4XNuPTAz/yyPszNBX0fQkGrN6Ybm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ild6cuZqrqhRSccQN+axzjgQyJkdNe1tFss8POiFyTbaMn4az8WhsrukeusDJHcBc
	 N9B7p0mRIKWTL2/lHzP28YHGimTgRAMlFbMVuinZsOsmWWxBsifmrePDq24z8df82k
	 Gwid2BmvFrn0cN/qwnruuVkhMsMuJa4GpChVgRuRvPF0F5F6q1ezXk/uQOoHN5HRV+
	 udoopgt3O/pzogFv89aSLMDEdT6Lj1pTAvuhxTNjSNG+LrHD6k5V6h6zggDjpk9YCE
	 ElgMp3dW209PavhdcD1qZ6j+dhl/YJqLo5jVdc6tr8BMhFHrJZDD22N+oBmTO12eCn
	 rM9LV305fKVzw==
Date: Thu, 6 Mar 2025 09:50:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 02/12] iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
Message-ID: <20250306-parabel-lernprogramm-abb674f8f75f@brauner>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <UQF0E8blbU4wMo9RdB7-nRkNAIJHtPkzDsTrQEOkNRLjG2CGbKe97G8XenXN1DSkhoWhipJrN956Enqgk9Ewkg==@protonmail.internalid>
 <20250303171120.2837067-3-john.g.garry@oracle.com>
 <mefv3axgsk567xwwwuoonvo7bncvdgu547ycvin5zjlztslotm@qu4fxqi3fave>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mefv3axgsk567xwwwuoonvo7bncvdgu547ycvin5zjlztslotm@qu4fxqi3fave>

On Wed, Mar 05, 2025 at 01:57:26PM +0100, Carlos Maiolino wrote:
> Hi Christian,
> On Mon, Mar 03, 2025 at 05:11:10PM +0000, John Garry wrote:
> > In future xfs will support a SW-based atomic write, so rename
> > IOMAP_ATOMIC -> IOMAP_ATOMIC_HW to be clear which mode is being used.
> > 
> > Also relocate setting of IOMAP_ATOMIC_HW to the write path in
> > __iomap_dio_rw(), to be clear that this flag is only relevant to writes.
> > 
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> I pushed the patches in this series into this branch:
> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git xfs-6.15-atomicwrites
> 
> Do you plan to send the iomap patches in this series yourself or is it ok with
> you if they go through xfs tree?

Ok, so this will have merge conflicts with vfs-6.15.iomap. I put the
preliminary iomap patches of this series onto vfs-6.15.iomap.

Please simply pull vfs-6.15.iomap instead of vfs-6.15.shared.iomap.
Nothing changes for you as everything has been kept stable. There'll be
no merge conflicts for us afterwards.

Thanks for the ping!

> 
> Cheers,
> Carlos
> 
> > ---
> >  Documentation/filesystems/iomap/operations.rst |  4 ++--
> >  fs/ext4/inode.c                                |  2 +-
> >  fs/iomap/direct-io.c                           | 18 +++++++++---------
> >  fs/iomap/trace.h                               |  2 +-
> >  include/linux/iomap.h                          |  2 +-
> >  5 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> > index d1535109587a..0b9d7be23bce 100644
> > --- a/Documentation/filesystems/iomap/operations.rst
> > +++ b/Documentation/filesystems/iomap/operations.rst
> > @@ -514,8 +514,8 @@ IOMAP_WRITE`` with any combination of the following enhancements:
> >     if the mapping is unwritten and the filesystem cannot handle zeroing
> >     the unaligned regions without exposing stale contents.
> > 
> > - * ``IOMAP_ATOMIC``: This write is being issued with torn-write
> > -   protection.
> > + * ``IOMAP_ATOMIC_HW``: This write is being issued with torn-write
> > +   protection based on HW-offload support.
> >     Only a single bio can be created for the write, and the write must
> >     not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
> >     set.
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 7c54ae5fcbd4..ba2f1e3db7c7 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3467,7 +3467,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> >  		return false;
> > 
> >  	/* atomic writes are all-or-nothing */
> > -	if (flags & IOMAP_ATOMIC)
> > +	if (flags & IOMAP_ATOMIC_HW)
> >  		return false;
> > 
> >  	/* can only try again if we wrote nothing */
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index e1e32e2bb0bf..c696ce980796 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -317,7 +317,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> >   * clearing the WRITE_THROUGH flag in the dio request.
> >   */
> >  static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> > -		const struct iomap *iomap, bool use_fua, bool atomic)
> > +		const struct iomap *iomap, bool use_fua, bool atomic_hw)
> >  {
> >  	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
> > 
> > @@ -329,7 +329,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
> >  		opflags |= REQ_FUA;
> >  	else
> >  		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> > -	if (atomic)
> > +	if (atomic_hw)
> >  		opflags |= REQ_ATOMIC;
> > 
> >  	return opflags;
> > @@ -340,8 +340,8 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> >  	const struct iomap *iomap = &iter->iomap;
> >  	struct inode *inode = iter->inode;
> >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > +	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
> >  	const loff_t length = iomap_length(iter);
> > -	bool atomic = iter->flags & IOMAP_ATOMIC;
> >  	loff_t pos = iter->pos;
> >  	blk_opf_t bio_opf;
> >  	struct bio *bio;
> > @@ -351,7 +351,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> >  	u64 copied = 0;
> >  	size_t orig_count;
> > 
> > -	if (atomic && length != fs_block_size)
> > +	if (atomic_hw && length != fs_block_size)
> >  		return -EINVAL;
> > 
> >  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> > @@ -428,7 +428,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> >  			goto out;
> >  	}
> > 
> > -	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
> > +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
> > 
> >  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
> >  	do {
> > @@ -461,7 +461,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
> >  		}
> > 
> >  		n = bio->bi_iter.bi_size;
> > -		if (WARN_ON_ONCE(atomic && n != length)) {
> > +		if (WARN_ON_ONCE(atomic_hw && n != length)) {
> >  			/*
> >  			 * This bio should have covered the complete length,
> >  			 * which it doesn't, so error. We may need to zero out
> > @@ -652,9 +652,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	if (iocb->ki_flags & IOCB_NOWAIT)
> >  		iomi.flags |= IOMAP_NOWAIT;
> > 
> > -	if (iocb->ki_flags & IOCB_ATOMIC)
> > -		iomi.flags |= IOMAP_ATOMIC;
> > -
> >  	if (iov_iter_rw(iter) == READ) {
> >  		/* reads can always complete inline */
> >  		dio->flags |= IOMAP_DIO_INLINE_COMP;
> > @@ -689,6 +686,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  			iomi.flags |= IOMAP_OVERWRITE_ONLY;
> >  		}
> > 
> > +		if (iocb->ki_flags & IOCB_ATOMIC)
> > +			iomi.flags |= IOMAP_ATOMIC_HW;
> > +
> >  		/* for data sync or sync, we need sync completion processing */
> >  		if (iocb_is_dsync(iocb)) {
> >  			dio->flags |= IOMAP_DIO_NEED_SYNC;
> > diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> > index 9eab2c8ac3c5..69af89044ebd 100644
> > --- a/fs/iomap/trace.h
> > +++ b/fs/iomap/trace.h
> > @@ -99,7 +99,7 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
> >  	{ IOMAP_FAULT,		"FAULT" }, \
> >  	{ IOMAP_DIRECT,		"DIRECT" }, \
> >  	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> > -	{ IOMAP_ATOMIC,		"ATOMIC" }
> > +	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
> > 
> >  #define IOMAP_F_FLAGS_STRINGS \
> >  	{ IOMAP_F_NEW,		"NEW" }, \
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index ea29388b2fba..87cd7079aaf3 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -189,7 +189,7 @@ struct iomap_folio_ops {
> >  #else
> >  #define IOMAP_DAX		0
> >  #endif /* CONFIG_FS_DAX */
> > -#define IOMAP_ATOMIC		(1 << 9)
> > +#define IOMAP_ATOMIC_HW		(1 << 9)
> >  #define IOMAP_DONTCACHE		(1 << 10)
> > 
> >  struct iomap_ops {
> > --
> > 2.31.1
> > 

