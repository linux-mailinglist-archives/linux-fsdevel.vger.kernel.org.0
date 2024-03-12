Return-Path: <linux-fsdevel+bounces-14219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945A8798DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5321C21CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058B7E0F3;
	Tue, 12 Mar 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCeIlxrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC17C6DE;
	Tue, 12 Mar 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260649; cv=none; b=C3h+gLmP7hrnLq3YPEk8iO49TzjzZUlGTWBzZkYInPYbNhNZx5Itmv2ggY62Ne2E8c7UFwYptZBqQygNDkpfQutMyYErL5w4LwraIxV4mvEbguTguiF6yuLGkN48zLeYM1NvNCqMjki0IkROtY88MGrl+dajMSlvsJgLQO8RFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260649; c=relaxed/simple;
	bh=8n2fKf4FY7dMDRLjK5X8wbktc/tbVnl2rTOrGpLEM1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlpsjyzgWpBt0JlaCCYtH12yXuYwz/g5IU5Nwrhgz6tW1W/BHQhZkSHuoQXguMQDwOok89BSnLWerOK1lskGjvpMhYLGjQy9rFfi3SGWshjf1iK9rLHaJx3Nt2/HNdsuCguLWA9csCiAi13p6OA25ghZ4TI2mD3Xtgz9zPP64E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCeIlxrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C614C433F1;
	Tue, 12 Mar 2024 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710260648;
	bh=8n2fKf4FY7dMDRLjK5X8wbktc/tbVnl2rTOrGpLEM1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCeIlxrh8lgfHk4zmd8tyjDO0plw4Y81Fpmn10i6qA5XBGMCvt00hBI0/qqg26lkW
	 rJJXoywLn5xbOGQcb6PCqe8yrCmcxghgnmjYeXfLI93WZMNCdQsnFEld3J6y6XDBRy
	 abQNNGWQcx7NuM5isTdmHr5FqmPeK7d5MmZ3ttSlJCHEGaG3IHdlX8agCbpNeuIQOa
	 WkI/S4u56GYnIuTLJahUPG5uIkIIyUC2R8K7OXdB6eeZoIl3xCMG5TEDw1pSE+/tlW
	 P0Gw4LM99S1xNloylybcBYv2qyeLwNEw7Jaakv84EGXE8OO3YdtUo7aB5SQvzF6sCP
	 sTQDpq+YcScgQ==
Date: Tue, 12 Mar 2024 09:24:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 3/4] iomap: don't increase i_size if it's not a write
 operation
Message-ID: <20240312162407.GC1927156@frogsfrogsfrogs>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-4-yi.zhang@huaweicloud.com>
 <20240311154829.GU1927156@frogsfrogsfrogs>
 <4a9e607e-36d1-4ea7-1754-c443906b3a1c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9e607e-36d1-4ea7-1754-c443906b3a1c@huaweicloud.com>

On Tue, Mar 12, 2024 at 08:59:15PM +0800, Zhang Yi wrote:
> On 2024/3/11 23:48, Darrick J. Wong wrote:
> > On Mon, Mar 11, 2024 at 08:22:54PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
> >> needed, the caller should handle it. Especially, when truncate partial
> >> block, we could not increase i_size beyond the new EOF here. It doesn't
> >> affect xfs and gfs2 now because they set the new file size after zero
> >> out, it doesn't matter that a transient increase in i_size, but it will
> >> affect ext4 because it set file size before truncate.
> > 
> >>                                                       At the same time,
> >> iomap_write_failed() is also not needed for above two cases too, so
> >> factor them out and move them to iomap_write_iter() and
> >> iomap_zero_iter().
> > 
> > This change should be a separate patch with its own justification.
> > Which is, AFAICT, something along the lines of:
> > 
> > "Unsharing and zeroing can only happen within EOF, so there is never a
> > need to perform posteof pagecache truncation if write begin fails."
> 
> Sure.
> 
> > 
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Doesn't this patch fix a bug in ext4?
> 
> Yeah, the same as Christoph answered.
> 
> > 
> >> ---
> >>  fs/iomap/buffered-io.c | 59 +++++++++++++++++++++---------------------
> >>  1 file changed, 30 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index 093c4515b22a..19f91324c690 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -786,7 +786,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> >>  
> >>  out_unlock:
> >>  	__iomap_put_folio(iter, pos, 0, folio);
> >> -	iomap_write_failed(iter->inode, pos, len);
> >>  
> >>  	return status;
> >>  }
> >> @@ -838,34 +837,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> >>  		size_t copied, struct folio *folio)
> >>  {
> >>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> >> -	loff_t old_size = iter->inode->i_size;
> >> -	size_t ret;
> >> -
> >> -	if (srcmap->type == IOMAP_INLINE) {
> >> -		ret = iomap_write_end_inline(iter, folio, pos, copied);
> >> -	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> >> -		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
> >> -				copied, &folio->page, NULL);
> >> -	} else {
> >> -		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
> >> -	}
> >>  
> >> -	/*
> >> -	 * Update the in-memory inode size after copying the data into the page
> >> -	 * cache.  It's up to the file system to write the updated size to disk,
> >> -	 * preferably after I/O completion so that no stale data is exposed.
> >> -	 */
> >> -	if (pos + ret > old_size) {
> >> -		i_size_write(iter->inode, pos + ret);
> >> -		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> >> -	}
> >> -	__iomap_put_folio(iter, pos, ret, folio);
> >> -
> >> -	if (old_size < pos)
> >> -		pagecache_isize_extended(iter->inode, old_size, pos);
> >> -	if (ret < len)
> >> -		iomap_write_failed(iter->inode, pos + ret, len - ret);
> >> -	return ret;
> >> +	if (srcmap->type == IOMAP_INLINE)
> >> +		return iomap_write_end_inline(iter, folio, pos, copied);
> >> +	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
> >> +		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
> >> +				       copied, &folio->page, NULL);
> >> +	return __iomap_write_end(iter->inode, pos, len, copied, folio);
> >>  }
> >>  
> >>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >> @@ -880,6 +858,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >>  
> >>  	do {
> >>  		struct folio *folio;
> >> +		loff_t old_size;
> >>  		size_t offset;		/* Offset into folio */
> >>  		size_t bytes;		/* Bytes to write to folio */
> >>  		size_t copied;		/* Bytes copied from user */
> >> @@ -912,8 +891,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >>  		}
> >>  
> >>  		status = iomap_write_begin(iter, pos, bytes, &folio);
> >> -		if (unlikely(status))
> >> +		if (unlikely(status)) {
> >> +			iomap_write_failed(iter->inode, pos, bytes);
> >>  			break;
> >> +		}
> >>  		if (iter->iomap.flags & IOMAP_F_STALE)
> >>  			break;
> >>  
> >> @@ -927,6 +908,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> >>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
> >>  
> >> +		/*
> >> +		 * Update the in-memory inode size after copying the data into
> >> +		 * the page cache.  It's up to the file system to write the
> >> +		 * updated size to disk, preferably after I/O completion so that
> >> +		 * no stale data is exposed.
> >> +		 */
> >> +		old_size = iter->inode->i_size;
> >> +		if (pos + status > old_size) {
> >> +			i_size_write(iter->inode, pos + status);
> >> +			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> >> +		}
> >> +		__iomap_put_folio(iter, pos, status, folio);
> > 
> > Why is it necessary to hoist the __iomap_put_folio calls from
> > iomap_write_end into iomap_write_iter, iomap_unshare_iter, and
> > iomap_zero_iter?  None of those functions seem to use it, and it makes
> > more sense to me that iomap_write_end releases the folio that
> > iomap_write_begin returned.
> > 
> 
> Because we have to update i_size before __iomap_put_folio() in
> iomap_write_iter(). If not, once we unlock folio, it could be raced
> by the backgroud write back which could start writing back and call
> folio_zero_segment() (please see iomap_writepage_handle_eof()) to
> zero out the valid data beyond the not updated i_size. So we
> have to move out __iomap_put_folio() out together with the i_size
> updating.

Ahah.  Please make a note of that in the comment for dunces like me.

	/*
	 * Update the in-memory inode size after copying the data into
	 * the page cache.  It's up to the file system to write the
	 * updated size to disk, preferably after I/O completion so that
	 * no stale data is exposed.  Only once that's done can we
	 * unlock and release the folio.
	 */

--D

> Thanks,
> Yi.
> 
> 

