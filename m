Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA00379A0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 00:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhEJW3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 18:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhEJW3C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 18:29:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7ADC61581;
        Mon, 10 May 2021 22:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620685677;
        bh=ehJYH3TD8ERjQHzpZ5B4TU4ritKItlOc4gX/puyPiYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nh89huUIIjieij8wReL/BCFHp+mbPvjMEH2Gjj5Ed44hDHUKaUxYpqhU5hFh8cKeO
         voauboPxP8elC2E4m1kBwQzrHnOyx+zoTbHIuENHzlVUsWVX7XOqAfZ6CFttfZXVee
         vTwIkXmHGTp5WsJ3ONqiouXTAqlWbJY4L1mmwZZ268aDIFwHfAs4HiJ3jxUX3JK9wG
         MC6hyuYrJl85kPCXvn3qvgCcnOIUl2CYEAgaCChI4muom9s4DZZngLRpJtzJ4dzLjL
         oyh+MoVTv95I7icIyUoVxketYfeITOfJlmVBX/4I+Nxvv1nUelGtpZ6gi6iRDZDAnE
         8L+fPCiAs8aFg==
Date:   Mon, 10 May 2021 15:27:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Fix readahead return types
Message-ID: <20210510222756.GI8582@magnolia>
References: <20210510201201.1558972-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510201201.1558972-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 09:12:01PM +0100, Matthew Wilcox (Oracle) wrote:
> A readahead request will not allocate more memory than can be represented
> by a size_t, even on systems that have HIGHMEM available.  Change the
> length functions from returning an loff_t to a size_t.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks reasonable to me; is this a 5.13 bugfix or just something that
doesn't look right (i.e. save it for 5.14)?

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c  | 4 ++--
>  include/linux/pagemap.h | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f2cd2034a87b..9023717c5188 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -394,7 +394,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  {
>  	struct inode *inode = rac->mapping->host;
>  	loff_t pos = readahead_pos(rac);
> -	loff_t length = readahead_length(rac);
> +	size_t length = readahead_length(rac);
>  	struct iomap_readpage_ctx ctx = {
>  		.rac	= rac,
>  	};
> @@ -402,7 +402,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	trace_iomap_readahead(inode, readahead_count(rac));
>  
>  	while (length > 0) {
> -		loff_t ret = iomap_apply(inode, pos, length, 0, ops,
> +		ssize_t ret = iomap_apply(inode, pos, length, 0, ops,
>  				&ctx, iomap_readahead_actor);
>  		if (ret <= 0) {
>  			WARN_ON_ONCE(ret == 0);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a4bd41128bf3..e89df447fae3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -997,9 +997,9 @@ static inline loff_t readahead_pos(struct readahead_control *rac)
>   * readahead_length - The number of bytes in this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline loff_t readahead_length(struct readahead_control *rac)
> +static inline size_t readahead_length(struct readahead_control *rac)
>  {
> -	return (loff_t)rac->_nr_pages * PAGE_SIZE;
> +	return rac->_nr_pages * PAGE_SIZE;
>  }
>  
>  /**
> @@ -1024,7 +1024,7 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
>   * readahead_batch_length - The number of bytes in the current batch.
>   * @rac: The readahead request.
>   */
> -static inline loff_t readahead_batch_length(struct readahead_control *rac)
> +static inline size_t readahead_batch_length(struct readahead_control *rac)
>  {
>  	return rac->_batch_count * PAGE_SIZE;
>  }
> -- 
> 2.30.2
> 
