Return-Path: <linux-fsdevel+bounces-13230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1874886D7D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 00:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E46B223D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6F7A15D;
	Thu, 29 Feb 2024 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5iTNON8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496C200CD;
	Thu, 29 Feb 2024 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249358; cv=none; b=c0tvF9/meOsBbHhnRRMJraUiTGs8tHGqTo9mGLDFIoNcLlG0KsIzuE1RdszsUzmLev5fTjqfC+w1qh2w/rUmVo4Hxqr1uizekEK227ypFgvle80qYvuSeV0bFDpWS7T6HPOFIMokTSYyfMHjwJ4Sq7FPrhakqW7F+5SwB/eVEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249358; c=relaxed/simple;
	bh=rlRoTcAkeLdFoK5I7nEY6DMlG7QMXz3Gox/lPZFNqfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0JBVT/doX3xhIpK3iWFIqW3cSCP65Szeib+bBgtXAr+t+Wnse05T3haNyXrFk82BxoIDo3pz8s8QlJeotMM1aCD1jJiKs96b8Afq6Lfa9LwHYr4WDgypPRd0pPZjO+u0CC+TQwfyk4VF4fYNG0c9TE2OFcfF943wGULQD3DW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5iTNON8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FCFC43330;
	Thu, 29 Feb 2024 23:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709249357;
	bh=rlRoTcAkeLdFoK5I7nEY6DMlG7QMXz3Gox/lPZFNqfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5iTNON8Mm6LlrZpl5rixdiN447xNZOSdfzeHKdJJLty3w57h9sugpm8FB3dxXDqI
	 MM+7fYLsH09bJDO+fW2VuyyOWfZU7qaRP0KTp2nd0S2BHfA7Av+kwHKN4BZq14vBGx
	 NCZBL5qSui2LqzRf8KS8oO82IDbGOcBw/SdA0xR1Ir+M/xoYskivqObRneatyAQf/G
	 kggdXwW9ID7lkAiSlMtiYvldXshZUrYICpxdiOBelHL8qaYS1vfdc1YuhUc2o36sqO
	 LJPfzX9dWp9m9NqVoHgM/5LvLA0yW6RjJgESrF/MizkfvjTy6TXeUmEzqdr2mGFbAF
	 6FNf/6KcUupFg==
Date: Thu, 29 Feb 2024 15:29:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>,
	Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, willy@infradead.org, zokeefe@google.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 07/26] iomap: don't increase i_size if it's not a
 write operation
Message-ID: <20240229232916.GE1927156@frogsfrogsfrogs>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-8-yi.zhang@huaweicloud.com>
 <ZcsCP4h-ExNOcdD6@infradead.org>
 <9b0040ef-3d9d-6246-4bdd-82b9a8f55fa2@huaweicloud.com>
 <Zd+y2VP8HpbkDu41@dread.disaster.area>
 <45c1607a-805d-e7a2-a5ca-3fd7e507a664@huaweicloud.com>
 <ZeERAob9Imwh01bG@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeERAob9Imwh01bG@dread.disaster.area>

On Fri, Mar 01, 2024 at 10:19:30AM +1100, Dave Chinner wrote:
> On Thu, Feb 29, 2024 at 04:59:34PM +0800, Zhang Yi wrote:
> > Hello, Dave!
> > 
> > On 2024/2/29 6:25, Dave Chinner wrote:
> > > On Wed, Feb 28, 2024 at 04:53:32PM +0800, Zhang Yi wrote:
> > >> On 2024/2/13 13:46, Christoph Hellwig wrote:
> > >>> Wouldn't it make more sense to just move the size manipulation to the
> > >>> write-only code?  An untested version of that is below.  With this
> > >>> the naming of the status variable becomes even more confusing than
> > >>> it already is, maybe we need to do a cleanup of the *_write_end
> > >>> calling conventions as it always returns the passed in copied value
> > >>> or 0.
> > >>>
> > >>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > >>> index 3dab060aed6d7b..8401a9ca702fc0 100644
> > >>> --- a/fs/iomap/buffered-io.c
> > >>> +++ b/fs/iomap/buffered-io.c
> > >>> @@ -876,34 +876,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> > >>>  		size_t copied, struct folio *folio)
> > >>>  {
> > >>>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > >>> -	loff_t old_size = iter->inode->i_size;
> > >>> -	size_t ret;
> > >>> -
> > >>> -	if (srcmap->type == IOMAP_INLINE) {
> > >>> -		ret = iomap_write_end_inline(iter, folio, pos, copied);
> > >>> -	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> > >>> -		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
> > >>> -				copied, &folio->page, NULL);
> > >>> -	} else {
> > >>> -		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
> > >>> -	}
> > >>> -
> > >>> -	/*
> > >>> -	 * Update the in-memory inode size after copying the data into the page
> > >>> -	 * cache.  It's up to the file system to write the updated size to disk,
> > >>> -	 * preferably after I/O completion so that no stale data is exposed.
> > >>> -	 */
> > >>> -	if (pos + ret > old_size) {
> > >>> -		i_size_write(iter->inode, pos + ret);
> > >>> -		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> > >>> -	}
> > >>
> > >> I've recently discovered that if we don't increase i_size in
> > >> iomap_zero_iter(), it would break fstests generic/476 on xfs. xfs
> > >> depends on iomap_zero_iter() to increase i_size in some cases.
> > >>
> > >>  generic/476 75s ... _check_xfs_filesystem: filesystem on /dev/pmem2 is inconsistent (r)
> > >>  (see /home/zhangyi/xfstests-dev/results//xfs/generic/476.full for details)
> > >>
> > >>  _check_xfs_filesystem: filesystem on /dev/pmem2 is inconsistent (r)
> > >>  *** xfs_repair -n output ***
> > >>  Phase 1 - find and verify superblock...
> > >>  Phase 2 - using internal log
> > >>          - zero log...
> > >>          - scan filesystem freespace and inode maps...
> > >>  sb_fdblocks 10916, counted 10923
> > >>          - found root inode chunk
> > >>  ...
> > >>
> > >> After debugging and analysis, I found the root cause of the problem is
> > >> related to the pre-allocations of xfs. xfs pre-allocates some blocks to
> > >> reduce fragmentation during buffer append writing, then if we write new
> > >> data or do file copy(reflink) after the end of the pre-allocating range,
> > >> xfs would zero-out and write back the pre-allocate space(e.g.
> > >> xfs_file_write_checks() -> xfs_zero_range()), so we have to update
> > >> i_size before writing back in iomap_zero_iter(), otherwise, it will
> > >> result in stale delayed extent.
> > > 
> > > Ok, so this is long because the example is lacking in clear details
> > > so to try to understand it I've laid it out in detail to make sure
> > > I've understood it correctly.
> > > 
> > 
> > Thanks for the graph, the added detail makes things clear and easy to
> > understand. To be honest, it's not exactly the same as the results I
> > captured and described (the position A\B\C\D\E\F I described is
> > increased one by one), but the root cause of the problem is the same,
> > so it doesn't affect our understanding of the problem.
> 
> OK, good :)
> 
> .....
> 
> > > However, if this did actually write zeroes to disk, this would end
> > > up with:
> > > 
> > > 	A          C           B     E       F      D
> > > 	+wwwwwwwwww+DDDDDDDDDDD+zzzzz+rrrrrrr+dddddd+
> > > 	                      EOF   EOF
> > >                       (in memory)   (on disk)
> > > 
> > > Which is wrong - the file extension and zeros should not get exposed
> > > to the user until the entire reflink completes. This would expose
> > > zeros at the EOF and a file size that the user never asked for after
> > > a crash. Experience tells me that they would report this as
> > > "filesystem corrupting data on crash".
> > > 
> > > If we move where i_size gets updated by iomap_zero_iter(), we get:
> > > 
> > > 	A          C           B     E       F      D
> > > 	+wwwwwwwwww+DDDDDDDDDDD+zzzzz+rrrrrrr+dddddd+
> > > 	                            EOF
> > >                                 (in memory)
> > > 		                 (on disk)
> > > 
> > > Which is also wrong, because now the user can see the size change
> > > and read zeros in the middle of the clone operation, which is also
> > > wrong.
> > > 
> > > IOWs, we do not want to move the in-memory or on-disk EOF as a
> > > result of zeroing delalloc extents beyond EOF as it opens up
> > > transient, non-atomic on-disk states in the event of a crash.
> > > 
> > > So, catch-22: we need to move the in-memory EOF to write back zeroes
> > > beyond EOF, but that would move the on-disk EOF to E before the
> > > clone operation starts. i.e. it makes clone non-atomic.
> > 
> > Make sense. IIUC, I also notice that xfs_file_write_checks() zero
> > out EOF blocks if the later write offset is beyond the size of the
> > file.  Think about if we replace the reflink operation to a buffer
> > write E to F, although it doesn't call xfs_flush_unmap_range()
> > directly, but if it could be raced by another background write
> > back, and trigger the same problem (I've not try to reproduce it,
> > so please correct me if I understand wrong).
> 
> Correct, but the write is about to extend the file size when it
> writes into the cache beyond the zeroed region. There is no cache
> invalidate possible in this path, so the write of data moves the
> in-memory EOF past the zeroes in cache and everything works just
> fine.
> 
> If it races with concurrent background writeback, the writeback will
> skip the zeroed range beyond EOF until they are exposed by the first
> data write beyond the zeroed post-eof region which moves the
> in-memory EOF.
> 
> truncate(to a larger size) also does this same zeroing - the page
> cache is zeroed before we move the EOF in memory, and so the
> writeback will only occur once the in-memory EOF is moved. i.e. it
> effectively does:
> 
> 	xfs_zero_range(oldsize to newsize)
> 	truncate_setsize(newsize)
> 	filemap_write_and_wait_range(old size to new size)
> 
> > > What should acutally result from the iomap_zero_range() call from
> > > xfs_reflink_remap_prep() is a state like this:
> > > 
> > > 	A          C           B     E       F      D
> > > 	+wwwwwwwwww+DDDDDDDDDDD+uuuuu+rrrrrrr+dddddd+
> > > 	          EOF         EOF
> > >                (on disk)  (in memory)
> > > 
> > > where 'u' are unwritten extent blocks.
> > > 
> > 
> > Yeah, this is a good solution.
> > 
> > In xfs_file_write_checks(), I don't fully understand why we need
> > the xfs_zero_range().
> 
> The EOF block may only be partially written. Hence on extension, we
> have to guarantee the part of that block beyond the current EOF is
> zero if the write leaves a hole between the current EOF and the
> start of the new extending write.
> 
> > Theoretically, iomap have already handled
> > partial block zeroing for both buffered IO and DIO, so I guess
> > the only reason we still need it is to handle pre-allocated blocks
> > (no?).
> 
> Historically speaking, Linux is able to leak data beyond EOF on
> writeback of partial EOF blocks (e.g. mmap() can write to the EOF
> page beyond EOF without failing. We try to mitigate these cases
> where we can, but we have to consider that at any time the data in
> the cache beyond EOF can be non-zero thanks to mmap() and so any
> file extension *must* zero any region beyond EOF cached in the page
> cache.
> 
> > If so，would it be better to call xfs_free_eofblocks() to
> > release all the preallocated extents in range? If not, maybe we
> > could only zero out mapped partial blocks and also release
> > preallocated extents?
> 
> No, that will cause all sorts of other performance problems,
> especially for reflinked files that triggering COW
> operations...
> 
> > 
> > In xfs_reflink_remap_prep(), I read the commit 410fdc72b05a ("xfs:
> > zero posteof blocks when cloning above eof"), xfs used to release
> > preallocations, the change log said it didn't work because of the
> > PREALLOC flag, but the 'force' parameter is 'true' when calling
> > xfs_can_free_eofblocks(), so I don't get the problem met. Could we
> > fall back to use xfs_free_eofblocks() and make a state like this?
> > 
> >  	A          C           B     E       F      D
> >  	+wwwwwwwwww+DDDDDDDDDDD+hhhhh+rrrrrrr+dddddd+
> >  	          EOF         EOF
> >                 (on disk)  (in memory)
> 
> It could, but that then requires every place that may call
> xfs_zero_range() to be aware of this need to trim EOF blocks to do
> the right thing in all cases. We don't want to remove speculative
> delalloc in the write() path nor in the truncate(up) case, and so it
> doesn't fix the general problem of zeroing specualtive delalloc
> beyond EOF requiring writeback to push page caceh pages to disk
> before the inode size has been updated.
> 
> The general solution is to have zeroing of speculative prealloc
> extents beyond EOF simply convert the range to unwritten and then
> invalidate any cached pages over that range. At this point, we are
> guaranteed to have zeroes across that range, all without needing to
> do any IO at all...

That (separate iomap ops that do the delalloc -> unwritten allocation)
seems a lot more straightforward to me than whacking preallocations.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

