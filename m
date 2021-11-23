Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB02C45AFB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhKWXFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:05:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232959AbhKWXFb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:05:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8792A60F9F;
        Tue, 23 Nov 2021 23:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637708542;
        bh=GS50QTQfJ1+ToyzIbpu55dsHnRqqv0iWy7BBdE0JB2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGGP2Hw/qt0fg0TjTYCkjZem7cLOTvAV+sYzt/gGFNVpe5YlzxKjG2+IdmBZqgOp0
         Tn14P64ZEMV4gebCdVgbL7CaMTp+X8CNJrxr0ZVMCKYY6k5XfA/+4EzCTh12rE7uwK
         fCo9ojaHmUFP3YFJWseiNw+SOmYbzBfz0SuuRHu/QcvKfxVhoRr5CXwdiB9KihiSTE
         OKdQ61mK9QOijxi5EjdC2NztG+GMSG+wrxjmHQLzMdOkMzK9cncUXf/Q/FakS6kyUJ
         su7FZZvTzHx1x8UJK7RJy9zA4zSLjCAN5QyeSRSJcE6pP1ZNqQvF4CqnWs+kY5B/nw
         RYEu1hk9aGLJQ==
Date:   Tue, 23 Nov 2021 15:02:22 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 24/29] xfs: use xfs_direct_write_iomap_ops for DAX zeroing
Message-ID: <20211123230222.GS266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-25-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:33:04AM +0100, Christoph Hellwig wrote:
> While the buffered write iomap ops do work due to the fact that zeroing
> never allocates blocks, the DAX zeroing should use the direct ops just
> like actual DAX I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Heh.  I've wanted to fix this for a long time, but I like your
surrounding cleanups better than anything I had time to work on. :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8cef3b68cba78..704292c6ce0c7 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1324,7 +1324,7 @@ xfs_zero_range(
>  
>  	if (IS_DAX(inode))
>  		return dax_zero_range(inode, pos, len, did_zero,
> -				      &xfs_buffered_write_iomap_ops);
> +				      &xfs_direct_write_iomap_ops);
>  	return iomap_zero_range(inode, pos, len, did_zero,
>  				&xfs_buffered_write_iomap_ops);
>  }
> @@ -1339,7 +1339,7 @@ xfs_truncate_page(
>  
>  	if (IS_DAX(inode))
>  		return dax_truncate_page(inode, pos, did_zero,
> -					&xfs_buffered_write_iomap_ops);
> +					&xfs_direct_write_iomap_ops);
>  	return iomap_truncate_page(inode, pos, did_zero,
>  				   &xfs_buffered_write_iomap_ops);
>  }
> -- 
> 2.30.2
> 
