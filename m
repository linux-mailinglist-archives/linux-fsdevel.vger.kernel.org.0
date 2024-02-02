Return-Path: <linux-fsdevel+bounces-10058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9901184760E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5131028EB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CEE14A4F2;
	Fri,  2 Feb 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqgWYQ71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F651474A1;
	Fri,  2 Feb 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894714; cv=none; b=PrBQuwymyOAUrWxb1lPGD0Cz2sQVhWMY8yF5x7mnucexBo36a3ABiyiAzyqknKzq6Y81fR1fqc3Cim5TRpCNwMbx8AsJp7CfCcsBLpqJDRUWqpy5IXXKFCyH+buc11J6pKx8lkWCdzB+d03WMBNrWCSnidg2CQEaULifGHY0kdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894714; c=relaxed/simple;
	bh=bL8+5y1uIX4CrzzBVdY7DuATZixLF3DqnJULrlkz1wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/jAMqZ2gC1NYGSJsKEtePGlUR7lzRLVETBTtFHWRugrB6bitnawktBh8YP/SB+nRS8+cBwVi4mKchygPczHsxHIxrjpsOXDVXp/Xv4mIH2/2lI7PywzR1S3ckZIXc243rtjr4+0m6izInU2X8ys2ujH9eDRg4XTVuyedSAbRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqgWYQ71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6D9C433C7;
	Fri,  2 Feb 2024 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706894713;
	bh=bL8+5y1uIX4CrzzBVdY7DuATZixLF3DqnJULrlkz1wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqgWYQ71rrPA7I2TRmZsG4KbtYfiJdPSxEhJnkIU2aj2dCrnU/dp5Bcrd19lg1k1R
	 33jQmpAZRi/AiqU+mTu4vtiT5lIVa2prncpU5vZTGur8bbuy0EVxuuZER9Mqni8/8o
	 kEHJ3A5LVvP0J8Hc2P1X/iNq6jwGaqW8HLQWkTK0K23lOm4bG/st4iRPSynEHr4zYt
	 CQeQb/y65oxX8HXqIBkT0PjQSx4raNGWO80h2KtcaFc2nS5egVSLoZ5/ndr/U3A8NB
	 CxKdXl7MZj61N7F5qg+9PelJnjoD/aCnJdLa7Q5tOXCs74fTw7YxZnmg+K2PTGaQDv
	 lTXkgpLo6JfMA==
Date: Fri, 2 Feb 2024 09:25:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 1/6] fs: iomap: Atomic write support
Message-ID: <20240202172513.GZ6226@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-2-john.g.garry@oracle.com>

On Wed, Jan 24, 2024 at 02:26:40PM +0000, John Garry wrote:
> Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
> bio is being created and all the rules there need to be followed.
> 
> It is the task of the FS iomap iter callbacks to ensure that the mapping
> created adheres to those rules, like size is power-of-2, is at a
> naturally-aligned offset, etc. However, checking for a single iovec, i.e.
> iter type is ubuf, is done in __iomap_dio_rw().
> 
> A write should only produce a single bio, so error when it doesn't.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c  | 21 ++++++++++++++++++++-
>  fs/iomap/trace.h      |  3 ++-
>  include/linux/iomap.h |  1 +
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..25736d01b857 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -275,10 +275,12 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		struct iomap_dio *dio)
>  {
> +	bool atomic_write = iter->flags & IOMAP_ATOMIC;
>  	const struct iomap *iomap = &iter->iomap;
>  	struct inode *inode = iter->inode;
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
>  	loff_t length = iomap_length(iter);
> +	const size_t iter_len = iter->len;
>  	loff_t pos = iter->pos;
>  	blk_opf_t bio_opf;
>  	struct bio *bio;
> @@ -381,6 +383,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  					  GFP_KERNEL);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  		bio->bi_ioprio = dio->iocb->ki_ioprio;
> +		if (atomic_write)
> +			bio->bi_opf |= REQ_ATOMIC;

This really ought to be in iomap_dio_bio_opflags.  Unless you can't pass
REQ_ATOMIC to bio_alloc*, in which case there ought to be a comment
about why.

Also, what's the meaning of REQ_OP_READ | REQ_ATOMIC?  Does that
actually work?  I don't know what that means, and "block: Add REQ_ATOMIC
flag" says that's not a valid combination.  I'll complain about this
more below.

> +
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> @@ -397,6 +402,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		}
>  
>  		n = bio->bi_iter.bi_size;
> +		if (atomic_write && n != iter_len) {

s/iter_len/orig_len/ ?

> +			/* This bio should have covered the complete length */
> +			ret = -EINVAL;
> +			bio_put(bio);
> +			goto out;
> +		}
>  		if (dio->flags & IOMAP_DIO_WRITE) {
>  			task_io_account_write(n);
>  		} else {
> @@ -554,12 +565,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  	loff_t ret = 0;
> +	bool is_read = iov_iter_rw(iter) == READ;
> +	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;

Hrmm.  So if the caller passes in an IOCB_ATOMIC iocb with a READ iter,
we'll silently drop IOCB_ATOMIC and do the read anyway?  That seems like
a nonsense combination, but is that ok for some reason?

>  	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
>  
>  	if (!iomi.len)
>  		return NULL;
>  
> +	if (atomic_write && !iter_is_ubuf(iter))
> +		return ERR_PTR(-EINVAL);

Does !iter_is_ubuf actually happen?  Why don't we support any of the
other ITER_ types?  Is it because hardware doesn't want vectored
buffers?

I really wish there was more commenting on /why/ we do things here:

	if (iocb->ki_flags & IOCB_ATOMIC) {
		/* atomic reads do not make sense */
		if (iov_iter_rw(iter) == READ)
			return ERR_PTR(-EINVAL);

		/*
		 * block layer doesn't want to handle handle vectors of
		 * buffers when performing an atomic write i guess?
		 */
		if (!iter_is_ubuf(iter))
			return ERR_PTR(-EINVAL);

		iomi.flags |= IOMAP_ATOMIC;
	}

> +
>  	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
>  	if (!dio)
>  		return ERR_PTR(-ENOMEM);
> @@ -579,7 +595,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> -	if (iov_iter_rw(iter) == READ) {
> +	if (is_read) {
>  		/* reads can always complete inline */
>  		dio->flags |= IOMAP_DIO_INLINE_COMP;
>  
> @@ -605,6 +621,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
>  			dio->flags |= IOMAP_DIO_CALLER_COMP;
>  
> +		if (atomic_write)
> +			iomi.flags |= IOMAP_ATOMIC;
> +
>  		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
>  			ret = -EAGAIN;
>  			if (iomi.pos >= dio->i_size ||
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index c16fd55f5595..c95576420bca 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_REPORT,		"REPORT" }, \
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
> -	{ IOMAP_NOWAIT,		"NOWAIT" }
> +	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> +	{ IOMAP_ATOMIC,		"ATOMIC" }
>  
>  #define IOMAP_F_FLAGS_STRINGS \
>  	{ IOMAP_F_NEW,		"NEW" }, \
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 96dd0acbba44..9eac704a0d6f 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -178,6 +178,7 @@ struct iomap_folio_ops {
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
> +#define IOMAP_ATOMIC		(1 << 9)
>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.31.1
> 
> 

