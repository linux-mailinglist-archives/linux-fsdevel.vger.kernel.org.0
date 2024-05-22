Return-Path: <linux-fsdevel+bounces-19952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D012A8CB951
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D1828187A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7658210;
	Wed, 22 May 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8b5ivsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AF139E;
	Wed, 22 May 2024 03:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716346821; cv=none; b=ebktA7ToZPKN8YAuFV6e0RFcvhhpSIm8oN6Uzk4AuGRNn+cCUGvf3Zs5H+WtRxF18vJlgftoaLj7UkWjK0Xw2tBzpYCSRph/uphgNyIo4P11l0Ju1Eo3HPBHaHithbKjDBaYNYdI+YWDsxX8GjGEfOCgMFfAcJvl0whsvouP8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716346821; c=relaxed/simple;
	bh=wQZj55jaaKJ9dRY35CiHLlwO+ti3BjVxpod5ND0gKSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5jkCqeOt//cWnlRme8aRjqoWPJRa8pKE3Uhy6dx2RTok5kqxOiIs8TulNyicyJAAoRGHCnCupRh0tWXsYoMweExBX9uAgvtLZaPtWSYkgRZVtar6DXbx3AAoKDDajuxRSAM7P7PiOEhaxjfTjpeTgMoFUWYGlPpLT28Ez54qHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8b5ivsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DBBC2BD11;
	Wed, 22 May 2024 03:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716346820;
	bh=wQZj55jaaKJ9dRY35CiHLlwO+ti3BjVxpod5ND0gKSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8b5ivsbXzo0xLyRfNPIvhl2rpDySsHJHVBldinYkl5FEb2Rc9jQ/MBYX+au8TzhX
	 nARjzcWDCHBXGMz9gkTthOPwhvo5/fqLIepGK2Nw+A8r2NLiyy2sHrm+9BdnffWTMo
	 CQyGQCvBP3dpMyryr6hHS1hkWsVTAjGoOqv/UsCS866rJbz8axON8gc/XQLaeZcYV6
	 BqZi+gaTy6stO9sycrCQRQg1Mn/vlmeT57+2a6m+6JWz8GAAVAjR7vukxajVGkNOlB
	 VLgvterUQKZxWVmSSUgiiQY4M5XvNs/uHPhYvVvuWJWRgH6hGtmmQlUQ8zsjTWRvKM
	 APv4CAwBvUyEQ==
Date: Tue, 21 May 2024 20:00:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
Message-ID: <20240522030020.GU25518@frogsfrogsfrogs>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
 <ZkwJJuFCV+WQLl40@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkwJJuFCV+WQLl40@dread.disaster.area>

On Tue, May 21, 2024 at 12:38:30PM +1000, Dave Chinner wrote:
> On Fri, May 17, 2024 at 07:13:55PM +0800, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > When truncating a realtime file unaligned to a shorter size,
> > xfs_setattr_size() only flush the EOF page before zeroing out, and
> > xfs_truncate_page() also only zeros the EOF block. This could expose
> > stale data since 943bc0882ceb ("iomap: don't increase i_size if it's not
> > a write operation").
> > 
> > If the sb_rextsize is bigger than one block, and we have a realtime
> > inode that contains a long enough written extent. If we unaligned
> > truncate into the middle of this extent, xfs_itruncate_extents() could
> > split the extent and align the it's tail to sb_rextsize, there maybe
> > have more than one blocks more between the end of the file. Since
> > xfs_truncate_page() only zeros the trailing portion of the i_blocksize()
> > value, so it may leftover some blocks contains stale data that could be
> > exposed if we append write it over a long enough distance later.
> > 
> > xfs_truncate_page() should flush, zeros out the entire rtextsize range,
> > and make sure the entire zeroed range have been flushed to disk before
> > updating the inode size.
> > 
> > Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
> > Reported-by: Chandan Babu R <chandanbabu@kernel.org>
> > Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > ---
> >  fs/xfs/xfs_iomap.c | 35 +++++++++++++++++++++++++++++++----
> >  fs/xfs/xfs_iops.c  | 10 ----------
> >  2 files changed, 31 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 4958cc3337bc..fc379450fe74 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1466,12 +1466,39 @@ xfs_truncate_page(
> >  	loff_t			pos,
> >  	bool			*did_zero)
> >  {
> > +	struct xfs_mount	*mp = ip->i_mount;
> >  	struct inode		*inode = VFS_I(ip);
> >  	unsigned int		blocksize = i_blocksize(inode);
> > +	int			error;
> > +
> > +	if (XFS_IS_REALTIME_INODE(ip))
> > +		blocksize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
> > +
> > +	/*
> > +	 * iomap won't detect a dirty page over an unwritten block (or a
> > +	 * cow block over a hole) and subsequently skips zeroing the
> > +	 * newly post-EOF portion of the page. Flush the new EOF to
> > +	 * convert the block before the pagecache truncate.
> > +	 */
> > +	error = filemap_write_and_wait_range(inode->i_mapping, pos,
> > +					     roundup_64(pos, blocksize));
> > +	if (error)
> > +		return error;
> >  
> >  	if (IS_DAX(inode))
> > -		return dax_truncate_page(inode, pos, blocksize, did_zero,
> > -					&xfs_dax_write_iomap_ops);
> > -	return iomap_truncate_page(inode, pos, blocksize, did_zero,
> > -				   &xfs_buffered_write_iomap_ops);
> > +		error = dax_truncate_page(inode, pos, blocksize, did_zero,
> > +					  &xfs_dax_write_iomap_ops);
> > +	else
> > +		error = iomap_truncate_page(inode, pos, blocksize, did_zero,
> > +					    &xfs_buffered_write_iomap_ops);
> > +	if (error)
> > +		return error;
> > +
> > +	/*
> > +	 * Write back path won't write dirty blocks post EOF folio,
> > +	 * flush the entire zeroed range before updating the inode
> > +	 * size.
> > +	 */
> > +	return filemap_write_and_wait_range(inode->i_mapping, pos,
> > +					    roundup_64(pos, blocksize));
> >  }
> 
> Ok, this means we do -three- blocking writebacks through this path
> instead of one or maybe two.
> 
> We already know that this existing blocking writeback case for dirty
> pages over unwritten extents is a significant performance issue for
> some workloads. I have a fix in progress for iomap to handle this
> case without requiring blocking writeback to be done to convert the
> extent to written before we do the truncate.
> 
> Regardless, I think this whole "truncate is allocation unit size
> aware" algorithm is largely unworkable without a rewrite. What XFS
> needs to do on truncate *down* before we start the truncate
> transaction is pretty simple:
> 
> 	- ensure that the new EOF extent tail contains zeroes
> 	- ensure that the range from the existing ip->i_disk_size to
> 	  the new EOF is on disk so data vs metadata ordering is
> 	  correct for crash recovery purposes.
> 
> What this patch does to acheive that is:
> 
> 	1. blocking writeback to clean dirty unwritten/cow blocks at
> 	the new EOF.
> 	2. iomap_truncate_page() writes zeroes into the page cache,
> 	which dirties the pages we just cleaned at the new EOF.
> 	3. blocking writeback to clean the dirty blocks at the new
> 	EOF.
> 	4. truncate_setsize() then writes zeros to partial folios at
> 	the new EOF, dirtying the EOF page again.
> 	5. blocking writeback to clean dirty blocks from the current
> 	on-disk size to the new EOF.
> 
> This is pretty crazy when you stop and think about it. We're writing
> the same EOF block -three- times. The first data write gets
> overwritten by zeroes on the second write, and the third write
> writes the same zeroes as the second write. There are two redundant
> *blocking* writes in this process.
> 
> We can do all this with a single writeback operation if we are a
> little bit smarter about the order of operations we perform and we
> are a little bit smarter in iomap about zeroing dirty pages in the
> page cache:
> 
> 	1. change iomap_zero_range() to do the right thing with
> 	dirty unwritten and cow extents (the patch I've been working
> 	on).
> 
> 	2. pass the range to be zeroed into iomap_truncate_page()
> 	(the fundamental change being made here).
> 
> 	3. zero the required range *through the page cache*
> 	(iomap_zero_range() already does this).
> 
> 	4. write back the XFS inode from ip->i_disk_size to the end
> 	of the range zeroed by iomap_truncate_page()
> 	(xfs_setattr_size() already does this).
> 
> 	5. i_size_write(newsize);
> 
> 	6. invalidate_inode_pages2_range(newsize, -1) to trash all
> 	the page cache beyond the new EOF without doing any zeroing
> 	as we've already done all the zeroing needed to the page
> 	cache through iomap_truncate_page().
> 
> 
> The patch I'm working on for step 1 is below. It still needs to be
> extended to handle the cow case, but I'm unclear on how to exercise
> that case so I haven't written the code to do it. The rest of it is
> just rearranging the code that we already use just to get the order
> of operations right. The only notable change in behaviour is using
> invalidate_inode_pages2_range() instead of truncate_pagecache(),
> because we don't want the EOF page to be dirtied again once we've
> already written zeroes to disk....
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> 
> [RFC] iomap: zeroing needs to be pagecache aware
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> Unwritten extents can have page cache data over the range being
> zeroed so we can't just skip them entirely. Fix this by checking for
> an existing dirty folio over the unwritten range we are zeroing
> and only performing zeroing if the folio is already dirty.
> 
> XXX: how do we detect a iomap containing a cow mapping over a hole
> in iomap_zero_iter()? The XFS code implies this case also needs to
> zero the page cache if there is data present, so trigger for page
> cache lookup only in iomap_zero_iter() needs to handle this case as
> well.

Hmm.  If memory serves, we probably need to adapt the
xfs_buffered/direct_write_iomap_begin functions to return the hole in
srcmap and the cow mapping in the iomap.  RN I think it just returns the
hole.

--D

> Before:
> 
> $ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
> path /mnt/scratch/foo, 50000 iters
> 
> real    0m14.103s
> user    0m0.015s
> sys     0m0.020s
> 
> $ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
> path /mnt/scratch/foo, 50000 iters
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  85.90    0.847616          16     50000           ftruncate
>  14.01    0.138229           2     50000           pwrite64
> ....
> 
> After:
> 
> $ time sudo ./pwrite-trunc /mnt/scratch/foo 50000
> path /mnt/scratch/foo, 50000 iters
> 
> real    0m0.144s
> user    0m0.021s
> sys     0m0.012s
> 
> $ sudo strace -c ./pwrite-trunc /mnt/scratch/foo 50000
> path /mnt/scratch/foo, 50000 iters
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  53.86    0.505964          10     50000           ftruncate
>  46.12    0.433251           8     50000           pwrite64
> ....
> 
> Yup, we get back all the performance.
> 
> As for the "mmap write beyond EOF" data exposure aspect
> documented here:
> 
> https://lore.kernel.org/linux-xfs/20221104182358.2007475-1-bfoster@redhat.com/
> 
> With this command:
> 
> $ sudo xfs_io -tfc "falloc 0 1k" -c "pwrite 0 1k" \
>   -c "mmap 0 4k" -c "mwrite 3k 1k" -c "pwrite 32k 4k" \
>   -c fsync -c "pread -v 3k 32" /mnt/scratch/foo
> 
> Before:
> 
> wrote 1024/1024 bytes at offset 0
> 1 KiB, 1 ops; 0.0000 sec (34.877 MiB/sec and 35714.2857 ops/sec)
> wrote 4096/4096 bytes at offset 32768
> 4 KiB, 1 ops; 0.0000 sec (229.779 MiB/sec and 58823.5294 ops/sec)
> 00000c00:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
> 00000c10:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
> read 32/32 bytes at offset 3072
> 32.000000 bytes, 1 ops; 0.0000 sec (568.182 KiB/sec and 18181.8182 ops/sec
> 
> After:
> 
> wrote 1024/1024 bytes at offset 0
> 1 KiB, 1 ops; 0.0000 sec (40.690 MiB/sec and 41666.6667 ops/sec)
> wrote 4096/4096 bytes at offset 32768
> 4 KiB, 1 ops; 0.0000 sec (150.240 MiB/sec and 38461.5385 ops/sec)
> 00000c00:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000c10:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> read 32/32 bytes at offset 3072
> 32.000000 bytes, 1 ops; 0.0000 sec (558.036 KiB/sec and 17857.1429 ops/sec)
> 
> We see that this post-eof unwritten extent dirty page zeroing is
> working correctly.
> 
> This has passed through most of fstests on a couple of test VMs
> without issues at the moment, so I think this approach to fixing the
> issue is going to be solid once we've worked out how to detect the
> COW-hole mapping case.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  fs/xfs/xfs_iops.c      | 12 +-----------
>  2 files changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4e8e41c8b3c0..6877474de0c9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -583,11 +583,23 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>   *
>   * Returns a locked reference to the folio at @pos, or an error pointer if the
>   * folio could not be obtained.
> + *
> + * Note: when zeroing unwritten extents, we might have data in the page cache
> + * over an unwritten extent. In this case, we want to do a pure lookup on the
> + * page cache and not create a new folio as we don't need to perform zeroing on
> + * unwritten extents if there is no cached data over the given range.
>   */
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>  {
>  	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
>  
> +	if (iter->flags & IOMAP_ZERO) {
> +		const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +
> +		if (srcmap->type == IOMAP_UNWRITTEN)
> +			fgp &= ~FGP_CREAT;
> +	}
> +
>  	if (iter->flags & IOMAP_NOWAIT)
>  		fgp |= FGP_NOWAIT;
>  	fgp |= fgf_set_order(len);
> @@ -1375,7 +1387,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  	loff_t written = 0;
>  
>  	/* already zeroed?  we're done. */
> -	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> +	if (srcmap->type == IOMAP_HOLE)
>  		return length;
>  
>  	do {
> @@ -1385,8 +1397,22 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		size_t bytes = min_t(u64, SIZE_MAX, length);
>  
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
> -		if (status)
> +		if (status) {
> +			if (status == -ENOENT) {
> +				/*
> +				 * Unwritten extents need to have page cache
> +				 * lookups done to determine if they have data
> +				 * over them that needs zeroing. If there is no
> +				 * data, we'll get -ENOENT returned here, so we
> +				 * can just skip over this index.
> +				 */
> +				WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN);
> +				if (bytes > PAGE_SIZE - offset_in_page(pos))
> +					bytes = PAGE_SIZE - offset_in_page(pos);
> +				goto loop_continue;
> +			}
>  			return status;
> +		}
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> @@ -1394,6 +1420,17 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (bytes > folio_size(folio) - offset)
>  			bytes = folio_size(folio) - offset;
>  
> +		/*
> +		 * If the folio over an unwritten extent is clean (i.e. because
> +		 * it has been read from), then it already contains zeros. Hence
> +		 * we can just skip it.
> +		 */
> +		if (srcmap->type == IOMAP_UNWRITTEN &&
> +		    !folio_test_dirty(folio)) {
> +			folio_unlock(folio);
> +			goto loop_continue;
> +		}
> +
>  		folio_zero_range(folio, offset, bytes);
>  		folio_mark_accessed(folio);
>  
> @@ -1401,6 +1438,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
> +loop_continue:
>  		pos += bytes;
>  		length -= bytes;
>  		written += bytes;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 8a145ca7d380..e8c9f3018c80 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -838,17 +838,7 @@ xfs_setattr_size(
>  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
>  		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
>  				&did_zeroing);
> -	} else {
> -		/*
> -		 * iomap won't detect a dirty page over an unwritten block (or a
> -		 * cow block over a hole) and subsequently skips zeroing the
> -		 * newly post-EOF portion of the page. Flush the new EOF to
> -		 * convert the block before the pagecache truncate.
> -		 */
> -		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
> -						     newsize);
> -		if (error)
> -			return error;
> +	} else if (newsize != oldsize) {
>  		error = xfs_truncate_page(ip, newsize, &did_zeroing);
>  	}
>  
> 

