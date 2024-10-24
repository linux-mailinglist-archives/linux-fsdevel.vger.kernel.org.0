Return-Path: <linux-fsdevel+bounces-32795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC39AED2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF421C210CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C91FAEE1;
	Thu, 24 Oct 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcU/yTPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F71DD0D9;
	Thu, 24 Oct 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789698; cv=none; b=PdQgNjn48IRxgCmgtYLu9Ewbcxi6eV8px4H9hjYsTinIILHmXf7J7TDspz/a/T+LP40punpIsh9GsjAQdymfMwnJrl7KjosN8a0iltExcaZl2JGINSeGuEvc98BAAf1OnmKYEx34j39v912ZSHUpbX885Hn3Ejd1eQyDiWfYRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789698; c=relaxed/simple;
	bh=robSyRUhettsUoVKqWt+6PBW83WMsbRSY2lHQ051nNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH7GJhf5r3oEydsqXxnRe6LVvC5+P3c8wXSC1B8LeUgYIOrWad1i5XLnU//3Anrpd0+C+2vAvKFH9qnSO10PCoa6NZqPnotOS/cKB2Ib6KEI9xqR2IgCK1TXfZCsCorT12oZKmWKkhKZK1AWD8ZXcfcwkJWg8QSEusZUNNOgucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcU/yTPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88173C4CEC7;
	Thu, 24 Oct 2024 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729789697;
	bh=robSyRUhettsUoVKqWt+6PBW83WMsbRSY2lHQ051nNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcU/yTPTvPiOABD4F8pAft/nUFJFBOiugH8NzotcAKsGuJFIlCYbRnMxcoi+a8lo7
	 G/C0GrqApHCsQTi2T5F7APK+Ol8s5wtfa6wnBSj8qh+l3rBc2Iowt8f8OMrQJpjLTK
	 pT6M9ORRy+kM1QiUIbvqCMZsEUonuMcEELbmkJrIddSOA6kS7G9fmMaYuWO3anv2CN
	 P4k0xdCbkFCsTa7TKYwyhvabFstbbKPWCKXqb2Swnn3rrBm2W16kS/hnmTHM7m8Pwx
	 W4Bjr8rBv92ugAzOyTxC2Lba2xxebDMvTVqLHMbGSzbhACh+lwP4BHrxLsl/Vte/LK
	 /K2ESoxuapcQQ==
Date: Thu, 24 Oct 2024 10:08:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: elide zero range flush from partial eof zeroing
Message-ID: <20241024170817.GK21853@frogsfrogsfrogs>
References: <20241023143029.11275-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023143029.11275-1-bfoster@redhat.com>

On Wed, Oct 23, 2024 at 10:30:29AM -0400, Brian Foster wrote:
> iomap zero range performs a pagecache flush upon seeing unwritten
> extents with dirty pagecache in order to determine accurate
> subranges that require direct zeroing. This is to support an
> optimization where clean, unwritten ranges are skipped as they are
> already zero on-disk.
> 
> Certain use cases for zero range are more sensitive to flush latency
> than others. The kernel test robot recently reported a regression in
> the following stress-ng workload on XFS:
> 
>   stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64
> 
> This workload involves a series of small, strided, write extending
> writes. On XFS, this produces a pattern of allocating post-eof
> speculative preallocation, converting preallocation to unwritten on
> zero range calls, dirtying pagecache over the converted mapping, and
> then repeating the sequence again from the updated EOF. This
> basically produces a sequence of pagecache flushes on the partial
> EOF block zeroing use case of zero range.
> 
> To mitigate this problem, special case the EOF block zeroing use
> case to prefer zeroing over a pagecache flush when the EOF folio is
> already dirty. This brings most of the performance back by avoiding
> flushes on write and truncate extension operations, while preserving
> the ability for iomap to flush and properly process larger ranges.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> Hi iomap maintainers,
> 
> This is an incremental optimization for the regression reported by the
> test robot here[1]. I'm not totally convinced this is necessary as an
> immediate fix, but the discussion on that thread was enough to suggest
> it could be. I don't really love the factoring, but I had to play a bit
> of whack-a-mole between fstests and stress-ng to restore performance and
> still maintain behavior expectations for some of the tests.
> 
> On a positive note, exploring this gave me what I think is a better idea
> for dealing with zero range overall, so I'm working on a followup to
> this that reworks it by splitting zero range across block alignment
> boundaries (similar to how something like truncate page range works, for
> example). This simplifies things by isolating the dirty range check to a
> single folio on an unaligned start offset, which lets the _iter() call
> do a skip or zero (i.e. no more flush_and_stale()), and then
> unconditionally flush the aligned portion to end-of-range. The latter
> flush should be a no-op for every use case I've seen so far, so this
> might entirely avoid the need for anything more complex for zero range.
> 
> In summary, I'm posting this as an optional and more "stable-worthy"
> patch for reference and for the maintainers to consider as they like. I
> think it's reasonable to include if we are concerned about this
> particular stress-ng test and are Ok with it as a transient solution.
> But if it were up to me, I'd probably sit on it for a bit to determine
> if a more practical user/workload is affected by this, particularly
> knowing that I'm trying to rework it. This could always be applied as a
> stable fix if really needed, but I just don't think the slightly more
> invasive rework is appropriate for -rc..
> 
> Thoughts, reviews, flames appreciated.
> 
> Brian
> 
> [1] https://lore.kernel.org/linux-xfs/202410141536.1167190b-oliver.sang@intel.com/
> 
>  fs/iomap/buffered-io.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index aa587b2142e2..8fd25b14d120 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1372,6 +1372,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
>  	loff_t written = 0;
> +	bool eof_zero = false;
>  
>  	/*
>  	 * We must zero subranges of unwritten mappings that might be dirty in
> @@ -1391,12 +1392,23 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  	 * triggers writeback time post-eof zeroing.
>  	 */
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
> -		if (*range_dirty) {
> +		/* range is clean and already zeroed, nothing to do */
> +		if (!*range_dirty)
> +			return length;
> +
> +		/* flush for anything other than partial eof zeroing */
> +		if (pos != i_size_read(iter->inode) ||
> +		   (pos % i_blocksize(iter->inode)) == 0) {
>  			*range_dirty = false;
>  			return iomap_zero_iter_flush_and_stale(iter);
>  		}
> -		/* range is clean and already zeroed, nothing to do */
> -		return length;
> +		/*
> +		 * Special case partial EOF zeroing. Since we know the EOF
> +		 * folio is dirty, prefer in-memory zeroing for it. This avoids
> +		 * excessive flush latency on frequent file size extending
> +		 * operations.
> +		 */
> +		eof_zero = true;
>  	}
>  
>  	do {
> @@ -1415,6 +1427,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  		offset = offset_in_folio(folio, pos);
>  		if (bytes > folio_size(folio) - offset)
>  			bytes = folio_size(folio) - offset;
> +		if (eof_zero && length > bytes)
> +			length = bytes;

What does this do?  I think this causes the loop to break after putting
the folio that caches @pos?  And then I guess we go around the loop in
iomap_zero_range again if there were more bytes to zero after this
folio?

--D

>  
>  		folio_zero_range(folio, offset, bytes);
>  		folio_mark_accessed(folio);
> -- 
> 2.46.2
> 
> 

