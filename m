Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364DF11D96A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 23:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfLLWeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 17:34:08 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38431 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730936AbfLLWeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:34:08 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9EEB38208B0;
        Fri, 13 Dec 2019 09:34:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ifX23-00061Q-20; Fri, 13 Dec 2019 09:34:03 +1100
Date:   Fri, 13 Dec 2019 09:34:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
Message-ID: <20191212223403.GH19213@dread.disaster.area>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <20191211152943.2933-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211152943.2933-6-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=ikgJNTgf4fhs6WZrna0A:9 a=RKUrkyyTLFFZf7Ed:21
        a=Xuacn0olY5J5TEqm:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 08:29:43AM -0700, Jens Axboe wrote:
> This adds support for RWF_UNCACHED for file systems using iomap to
> perform buffered writes. We use the generic infrastructure for this,
> by tracking pages we created and calling write_drop_cached_pages()
> to issue writeback and prune those pages.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/iomap/apply.c       | 24 ++++++++++++++++++++++++
>  fs/iomap/buffered-io.c | 37 +++++++++++++++++++++++++++++--------
>  include/linux/iomap.h  |  5 +++++
>  3 files changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 562536da8a13..966826ad4bb9 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -90,5 +90,29 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  				     flags, &iomap);
>  	}
>  
> +	if (written && (flags & IOMAP_UNCACHED)) {
> +		struct address_space *mapping = inode->i_mapping;
> +
> +		end = pos + written;
> +		ret = filemap_write_and_wait_range(mapping, pos, end);
> +		if (ret)
> +			goto out;
> +
> +		/*
> +		 * No pages were created for this range, we're done
> +		 */
> +		if (!(iomap.flags & IOMAP_F_PAGE_CREATE))
> +			goto out;
> +
> +		/*
> +		 * Try to invalidate cache pages for the range we just wrote.
> +		 * We don't care if invalidation fails as the write has still
> +		 * worked and leaving clean uptodate pages in the page cache
> +		 * isn't a corruption vector for uncached IO.
> +		 */
> +		invalidate_inode_pages2_range(mapping,
> +				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> +	}
> +out:
>  	return written ? written : ret;
>  }

Just a thought on further optimisation for this for XFS.
IOMAP_UNCACHED is being passed into the filesystem ->iomap_begin
methods by iomap_apply().  Hence the filesystems know that it is
an uncached IO that is being done, and we can tailor allocation
strategies to suit the fact that the data is going to be written
immediately.

In this case, XFS needs to treat it the same way it treats direct
IO. That is, we do immediate unwritten extent allocation rather than
delayed allocation. This will reduce the allocation overhead and
will optimise for immediate IO locality rather than optimise for
delayed allocation.

This should just be a relatively simple change to
xfs_file_iomap_begin() along the lines of:

-	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) && !(flags & IOMAP_DIRECT) &&
-			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
+	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
+	    !(flags & (IOMAP_DIRECT | IOMAP_UNCACHED)) &&
+	    !IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
		/* Reserve delalloc blocks for regular writeback. */
		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
				iomap);
	}

so that it avoids delayed allocation for uncached IO...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
