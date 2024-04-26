Return-Path: <linux-fsdevel+bounces-17931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363518B3E5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E619B26000
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954415CD51;
	Fri, 26 Apr 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mj+tWsyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B511DDF8;
	Fri, 26 Apr 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153071; cv=none; b=uVU2kLbtm5qrtdjnZ0mAPbxAjWu4QCdDf/bcQEoCW3Up1oPTGy9p5XNP4rZ0fY/f7nq19EeZed+qLZaqURnuHlBOOg2Ti60Krr66O1G+oJpQ/VlNO7ATvt/diHLePpRfsAtLUX3+6MvQNJqANuaBhHhoqlzNobnW9dIAsFxCGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153071; c=relaxed/simple;
	bh=qNq8yQyEy0OBCoAzFEte5m9Y6oHS+xyiJzwsQLdwTFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKj2nojHkSoGBTJsRm2zrc80N0U3p2uRwg79CIcjZT9714P3rCLbEmZrVFg6ml8FNwGs3osseSKKngeoexjzL8Xf5HpJKG53D3VqG6KTZHEbf1mx5t8d7m31WfDRzh43IrxootzZs7QqCo3WHM3Db+Xanvu9fSO3bUnYPlkWo7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mj+tWsyT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cBmz3Nw/GHTIFcJky7xvIcFnhzNmSdYD/JSgAqNWR6o=; b=Mj+tWsyTesfegw/IFwrTYuYWGx
	zO9ygP+TIWkBvtC1ZrU4iNanOUOjzbfrybmkQFGqopACjwlwpU9Rny23IPKRwg/ClYoNVv4rOXJZv
	usBDA+jPH7FIYyNACpHml6OzHM10H8lqqTMRbCFYjGBFbS8Pmt3qZqpJ3MLsFe77IzluOnwygmpn3
	rqShI5fPkK/1GMu2D8sKu7XMPoiDfov4GuXv/5fet/UB1xwpCe9/vUHVT+nktXLZyjxmcmu939r+l
	lmrHtuCA7LASpa3f2ipzn1OaofC2iUz7w0tWHUzI3o/oXD3vziS5p5hSvrKVO08mjD0vocD4OHOTw
	vJ52D92A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0PW5-00000005h4c-0YBq;
	Fri, 26 Apr 2024 17:37:45 +0000
Date: Fri, 26 Apr 2024 18:37:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 7/7] iomap: Optimize data access patterns for filesystems
 with indirect mappings
Message-ID: <ZivmaVAvnyQ8kKHi@casper.infradead.org>
References: <87a5lgyrfk.fsf@gmail.com>
 <877cgkyr24.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cgkyr24.fsf@gmail.com>

On Fri, Apr 26, 2024 at 10:55:23PM +0530, Ritesh Harjani wrote:
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> 
> > "Darrick J. Wong" <djwong@kernel.org> writes:
> >
> >> On Thu, Apr 25, 2024 at 06:58:51PM +0530, Ritesh Harjani (IBM) wrote:
> >>> This patch optimizes the data access patterns for filesystems with
> >>> indirect block mapping by implementing BH_Boundary handling within
> >>> iomap.
> >>> 
> >>> Currently the bios for reads within iomap are only submitted at
> >>> 2 places -
> >>> 1. If we cannot merge the new req. with previous bio, only then we
> >>>    submit the previous bio.
> >>> 2. Submit the bio at the end of the entire read processing.
> >>> 
> >>> This means for filesystems with indirect block mapping, we call into
> >>> ->iomap_begin() again w/o submitting the previous bios. That causes
> >>> unoptimized data access patterns for blocks which are of BH_Boundary type.
> >>> 
> >>> For e.g. consider the file mapping
> >>> logical block(4k) 		physical block(4k)
> >>> 0-11 				1000-1011
> >>> 12-15 				1013-1016
> >>> 
> >>> In above physical block 1012 is an indirect metadata block which has the
> >>> mapping information for next set of indirect blocks (1013-1016).
> >>> With iomap buffered reads for reading 1st 16 logical blocks of a file
> >>> (0-15), we get below I/O pattern
> >>> 	- submit a bio for 1012
> >>> 	- complete the bio for 1012
> >>> 	- submit a bio for 1000-1011
> >>> 	- submit a bio for 1013-1016
> >>> 	- complete the bios for 1000-1011
> >>> 	- complete the bios for 1013-1016
> >>> 
> >>> So as we can see, above is an non-optimal I/O access pattern and also we
> >>> get 3 bio completions instead of 2.
> >>> 
> >>> This patch changes this behavior by doing submit_bio() if there are any
> >>> bios already processed, before calling ->iomap_begin() again.
> >>> That means if there are any blocks which are already processed, gets
> >>> submitted for I/O earlier and then within ->iomap_begin(), if we get a
> >>> request for reading an indirect metadata block, then block layer can merge
> >>> those bios with the already submitted read request to reduce the no. of bio
> >>> completions.
> >>> 
> >>> Now, for bs < ps or for large folios, this patch requires proper handling
> >>> of "ifs->read_bytes_pending". In that we first set ifs->read_bytes_pending
> >>> to folio_size. Then handle all the cases where we need to subtract
> >>> ifs->read_bytes_pending either during the submission side
> >>> (if we don't need to submit any I/O - for e.g. for uptodate sub blocks),
> >>> or during an I/O error, or at the completion of an I/O.
> >>> 
> >>> Here is the ftrace output of iomap and block layer with ext2 iomap
> >>> conversion patches -
> >>> 
> >>> root# filefrag -b512 -v /mnt1/test/f1
> >>> Filesystem type is: ef53
> >>> Filesystem cylinder groups approximately 32
> >>> File size of /mnt1/test/f1 is 65536 (128 blocks of 512 bytes)
> >>>  ext:     logical_offset:        physical_offset: length:   expected: flags:
> >>>    0:        0..      95:      98304..     98399:     96:             merged
> >>>    1:       96..     127:      98408..     98439:     32:      98400: last,merged,eof
> >>> /mnt1/test/f1: 2 extents found
> >>> 
> >>> root# #This reads 4 blocks starting from lblk 10, 11, 12, 13
> >>> root# xfs_io -c "pread -b$((4*4096)) $((10*4096)) $((4*4096))" /mnt1/test/f1
> >>> 
> >>> w/o this patch - (indirect block is submitted before and does not get merged, resulting in 3 bios completion)
> >>>       xfs_io-907     [002] .....   185.608791: iomap_readahead: dev 8:16 ino 0xc nr_pages 4
> >>>       xfs_io-907     [002] .....   185.608819: iomap_iter: dev 8:16 ino 0xc pos 0xa000 length 0x4000 processed 0 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x9d/0x2c0
> >>>       xfs_io-907     [002] .....   185.608823: iomap_iter_dstmap: dev 8:16 ino 0xc bdev 8:16 addr 0x300a000 offset 0xa000 length 0x2000 type MAPPED flags MERGED
> >>>       xfs_io-907     [002] .....   185.608831: iomap_iter: dev 8:16 ino 0xc pos 0xa000 length 0x2000 processed 8192 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x1e1/0x2c0
> >>>       xfs_io-907     [002] .....   185.608859: block_bio_queue: 8,16 R 98400 + 8 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.608865: block_getrq: 8,16 R 98400 + 8 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.608867: block_io_start: 8,16 R 4096 () 98400 + 8 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.608869: block_plug: [xfs_io]
> >>>       xfs_io-907     [002] .....   185.608872: block_unplug: [xfs_io] 1
> >>>       xfs_io-907     [002] .....   185.608874: block_rq_insert: 8,16 R 4096 () 98400 + 8 [xfs_io]
> >>> kworker/2:1H-198     [002] .....   185.608908: block_rq_issue: 8,16 R 4096 () 98400 + 8 [kworker/2:1H]
> >>>       <idle>-0       [002] d.h2.   185.609579: block_rq_complete: 8,16 R () 98400 + 8 [0]
> >>>       <idle>-0       [002] dNh2.   185.609631: block_io_done: 8,16 R 0 () 98400 + 0 [swapper/2]
> >>>       xfs_io-907     [002] .....   185.609694: iomap_iter_dstmap: dev 8:16 ino 0xc bdev 8:16 addr 0x300d000 offset 0xc000 length 0x2000 type MAPPED flags MERGED
> >>>       xfs_io-907     [002] .....   185.609704: block_bio_queue: 8,16 RA 98384 + 16 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.609718: block_getrq: 8,16 RA 98384 + 16 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.609721: block_io_start: 8,16 RA 8192 () 98384 + 16 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.609726: block_plug: [xfs_io]
> >>>       xfs_io-907     [002] .....   185.609735: iomap_iter: dev 8:16 ino 0xc pos 0xc000 length 0x2000 processed 8192 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x1e1/0x2c0
> >>>       xfs_io-907     [002] .....   185.609736: block_bio_queue: 8,16 RA 98408 + 16 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.609740: block_getrq: 8,16 RA 98408 + 16 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.609741: block_io_start: 8,16 RA 8192 () 98408 + 16 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.609756: block_rq_issue: 8,16 RA 8192 () 98408 + 16 [xfs_io]
> >>>       xfs_io-907     [002] .....   185.609769: block_rq_issue: 8,16 RA 8192 () 98384 + 16 [xfs_io]
> >>>       <idle>-0       [002] d.H2.   185.610280: block_rq_complete: 8,16 RA () 98408 + 16 [0]
> >>>       <idle>-0       [002] d.H2.   185.610289: block_io_done: 8,16 RA 0 () 98408 + 0 [swapper/2]
> >>>       <idle>-0       [002] d.H2.   185.610292: block_rq_complete: 8,16 RA () 98384 + 16 [0]
> >>>       <idle>-0       [002] dNH2.   185.610301: block_io_done: 8,16 RA 0 () 98384 + 0 [swapper/2]
> >>
> >> Could this be shortened to ... the iomap calls and
> >> block_bio_queue/backmerge?  It's a bit difficult to see the point you're
> >> getting at with all the other noise.
> >
> > I will remove this log and move it to cover letter and will just extend
> > the simple example I considered before in this commit message,
> > to show the difference with and w/o patch.
> >
> >>
> >> I think you're trying to say that the access pattern here is 98400 ->
> >> 98408 -> 98384, which is not sequential?
> >>
> >
> > it's (98400,8 ==> metadata block) -> (98384,16 == lblk 10 & 11) -> (98408,16 ==> lblk 12 & 13)
> > ... w/o the patch
> >
> >>> v/s with the patch - (optimzed I/O access pattern and bio gets merged resulting in only 2 bios completion)
> >>>       xfs_io-944     [005] .....    99.926187: iomap_readahead: dev 8:16 ino 0xc nr_pages 4
> >>>       xfs_io-944     [005] .....    99.926208: iomap_iter: dev 8:16 ino 0xc pos 0xa000 length 0x4000 processed 0 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x9d/0x2c0
> >>>       xfs_io-944     [005] .....    99.926211: iomap_iter_dstmap: dev 8:16 ino 0xc bdev 8:16 addr 0x300a000 offset 0xa000 length 0x2000 type MAPPED flags MERGED
> >>>       xfs_io-944     [005] .....    99.926222: block_bio_queue: 8,16 RA 98384 + 16 [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926232: block_getrq: 8,16 RA 98384 + 16 [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926233: block_io_start: 8,16 RA 8192 () 98384 + 16 [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926234: block_plug: [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926235: iomap_iter: dev 8:16 ino 0xc pos 0xa000 length 0x2000 processed 8192 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x1f9/0x2c0
> >>>       xfs_io-944     [005] .....    99.926261: block_bio_queue: 8,16 R 98400 + 8 [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926266: block_bio_backmerge: 8,16 R 98400 + 8 [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926271: block_unplug: [xfs_io] 1
> >>>       xfs_io-944     [005] .....    99.926272: block_rq_insert: 8,16 RA 12288 () 98384 + 24 [xfs_io]
> >>> kworker/5:1H-234     [005] .....    99.926314: block_rq_issue: 8,16 RA 12288 () 98384 + 24 [kworker/5:1H]
> >>>       <idle>-0       [005] d.h2.    99.926905: block_rq_complete: 8,16 RA () 98384 + 24 [0]
> >>>       <idle>-0       [005] dNh2.    99.926931: block_io_done: 8,16 RA 0 () 98384 + 0 [swapper/5]
> >>>       xfs_io-944     [005] .....    99.926971: iomap_iter_dstmap: dev 8:16 ino 0xc bdev 8:16 addr 0x300d000 offset 0xc000 length 0x2000 type MAPPED flags MERGED
> >>>       xfs_io-944     [005] .....    99.926981: block_bio_queue: 8,16 RA 98408 + 16 [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926989: block_getrq: 8,16 RA 98408 + 16 [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926989: block_io_start: 8,16 RA 8192 () 98408 + 16 [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926991: block_plug: [xfs_io]
> >>>       xfs_io-944     [005] .....    99.926993: iomap_iter: dev 8:16 ino 0xc pos 0xc000 length 0x2000 processed 8192 flags  (0x0) ops 0xffffffff82242160 caller iomap_readahead+0x1f9/0x2c0
> >>>       xfs_io-944     [005] .....    99.927001: block_rq_issue: 8,16 RA 8192 () 98408 + 16 [xfs_io]
> >>>       <idle>-0       [005] d.h2.    99.927397: block_rq_complete: 8,16 RA () 98408 + 16 [0]
> >>>       <idle>-0       [005] dNh2.    99.927414: block_io_done: 8,16 RA 0 () 98408 + 0 [swapper/5]
> >>> 
> >>> Suggested-by: Matthew Wilcox <willy@infradead.org>
> >>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >>> cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >>> ---
> >>>  fs/iomap/buffered-io.c | 112 +++++++++++++++++++++++++++++++----------
> >>>  1 file changed, 85 insertions(+), 27 deletions(-)
> >>> 
> >>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >>> index 0a4269095ae2..a1d50086a3f5 100644
> >>> --- a/fs/iomap/buffered-io.c
> >>> +++ b/fs/iomap/buffered-io.c
> >>> @@ -30,7 +30,7 @@ typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
> >>>   */
> >>>  struct iomap_folio_state {
> >>>  	spinlock_t		state_lock;
> >>> -	unsigned int		read_bytes_pending;
> >>> +	size_t			read_bytes_pending;
> >>>  	atomic_t		write_bytes_pending;
> >>> 
> >>>  	/*
> >>> @@ -380,6 +380,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> >>>  	loff_t orig_pos = pos;
> >>>  	size_t poff, plen;
> >>>  	sector_t sector;
> >>> +	bool rbp_finished = false;
> >>
> >> What is "rbp"?  My assembly programmer brain says x64 frame pointer, but
> >> that's clearly wrong here.  Maybe I'm confused...
> >>
> >
> > rbp == read_bytes_pending ;)
> >
> >>>  	if (iomap->type == IOMAP_INLINE)
> >>>  		return iomap_read_inline_data(iter, folio);
> >>> @@ -387,21 +388,39 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> >>>  	/* zero post-eof blocks as the page may be mapped */
> >>>  	ifs = ifs_alloc(iter->inode, folio, iter->flags);
> >>>  	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
> >>> +
> >>> +	if (ifs) {
> >>> +		loff_t to_read = min_t(loff_t, iter->len - offset,
> >>> +			folio_size(folio) - offset_in_folio(folio, orig_pos));
> >>> +		size_t padjust;
> >>> +
> >>> +		spin_lock_irq(&ifs->state_lock);
> >>> +		if (!ifs->read_bytes_pending)
> >>> +			ifs->read_bytes_pending = to_read;
> >>> +		padjust = pos - orig_pos;
> >>> +		ifs->read_bytes_pending -= padjust;
> >>> +		if (!ifs->read_bytes_pending)
> >>> +			rbp_finished = true;
> >>> +		spin_unlock_irq(&ifs->state_lock);
> >>> +	}
> >>> +
> >>>  	if (plen == 0)
> >>>  		goto done;
> >>> 
> >>>  	if (iomap_block_needs_zeroing(iter, pos)) {
> >>> +		if (ifs) {
> >>> +			spin_lock_irq(&ifs->state_lock);
> >>> +			ifs->read_bytes_pending -= plen;
> >>> +			if (!ifs->read_bytes_pending)
> >>> +				rbp_finished = true;
> >>> +			spin_unlock_irq(&ifs->state_lock);
> >>> +		}
> >>>  		folio_zero_range(folio, poff, plen);
> >>>  		iomap_set_range_uptodate(folio, poff, plen);
> >>>  		goto done;
> >>>  	}
> >>> 
> >>>  	ctx->cur_folio_in_bio = true;
> >>> -	if (ifs) {
> >>> -		spin_lock_irq(&ifs->state_lock);
> >>> -		ifs->read_bytes_pending += plen;
> >>> -		spin_unlock_irq(&ifs->state_lock);
> >>> -	}
> >>> 
> >>>  	sector = iomap_sector(iomap, pos);
> >>>  	if (!ctx->bio ||
> >>> @@ -435,6 +454,14 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> >>>  	}
> >>> 
> >>>  done:
> >>> +	/*
> >>> +	 * If there is no bio prepared and if rbp is finished and
> >>> +	 * this was the last offset within this folio then mark
> >>> +	 * cur_folio_in_bio to false.
> >>> +	 */
> >>> +	if (!ctx->bio && rbp_finished &&
> >>> +			offset_in_folio(folio, pos + plen) == 0)
> >>> +		ctx->cur_folio_in_bio = false;
> >>
> >> ...yes, I think I am confused.  When would ctx->bio be NULL but
> >> cur_folio_in_bio is true?
> >
> > Previously we had the bio submitted and so we make it null, but we still
> > have ctx->cur_folio & ctx->cur_folio_in_bio to true, since we haven't
> > completely processed the folio.
> >
> >>
> >> I /think/ what you're doing here is using read_bytes_pending to figure
> >> out if you've processed the folio up to the end of the mapping?  But
> >> then you submit the bio unconditionally below for each readpage_iter
> >> call?
> >>
> >
> > yes, that's right.
> >
> >> Why not add an IOMAP_BOUNDARY flag that means "I will have to do some IO
> >> if you call ->iomap_begin again"?  Then if we get to this point in
> >> readpage_iter with a ctx->bio, we can submit the bio, clear
> >> cur_folio_in_bio, and return?  And then you don't need this machinery?
> >
> > TBH, I initially didn't think the approach taken in the patch would
> > require such careful handling of r_b_p. It was because of all of this
> > corner cases when we don't need to read the update blocks and/or in case
> > of an error we need to ensure we reduce r_b_p carefully so that we could
> > unlock the folio and when extent spans beyond i_size.
> >
> > So it's all about how do we know if we could unlock the folio and that it's
> > corresponding blocks/mapping has been all processed or submitted for
> > I/O. 
> >
> > Assume we have a folio which spans over multiple extents. In such a
> > case, 
> > -> we process a bio for 1st extent, 
> > -> then we go back to iomap_iter() to get new extent mapping, 
> > -> We now increment the r_b_p with this new plen to be processed. 
> > -> We then submit the previous bio, since this new mapping couldn't be
> > merged due to discontinuous extents. 
> > So by first incrementing the r_b_p before doing submit_bio(), we don't
> > unlock the folio at bio completion.
> >
> > Maybe, it would be helpful if we have an easy mechanism to keep some state
> > from the time of submit_bio() till the bio completion to know that the
> > corresponding folio is still being processed and it shouldn't be
> > unlocked.
> >  -> This currently is what we are doing by making r_b_p to the value of
> >  folio_size() and then carefully reducing r_b_p for all the cases I
> >  mentioned above.
> >
> > Let me think if adding a IOMAP_BH_BOUNDARY flag could be helpful or not.
> > Say if we have a pagesize of 64k that means all first 16 blocks belongs
> > to same page. So even with IOMAP_BH_BOUNDARY flag the problem that still
> > remains is that, even if we submit the bio at block 11 (bh_boundary
> > block), how will the bio completion side know that the folio is not
> > completely processed and so we shouldn't unlock the folio?
> 
> Maybe one way could be if we could add another state flag to ifs for
> BH_BOUNDARY block and read that at the bio completion.
> We can then also let the completion side know if it should unlock the
> folio or whether it still needs processing at the submission side.

The approach I suggested was to initialise read_bytes_pending to
folio_size() at the start.  Then subtract off blocksize for each
uptodate block, whether you find it already uptodate, or as the
completion handler runs.

Is there a reason that doesn't work?

