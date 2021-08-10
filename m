Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5443E3E86E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 01:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhHJX7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 19:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234289AbhHJX7T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:59:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3221D60F94;
        Tue, 10 Aug 2021 23:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628639936;
        bh=DJrzutjtjo/Yj+2bRkiBSl61pRlqxhzQ6EU0MmzGhKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzdVvvKdeU6hRoECPa4czwIhq9p6qQgTp/GEEPIROQvvFyKI6534grs+WpGM87KqL
         CTctBHOLNNMe29jeStqovXFgivXU/Z4iS4coCqyDWS9FZfHaGWZH/jL3eOVQ4Ze78P
         Y0e/xaM1JW0yvc9ECca0UemWtCr5hZQM9H9+RaVJVIO7TjNjixmyJRSHII3pwBXHVr
         W6cXGoPdx6CDpK+DpJqAuVqmyT8t05Fb8UY76S1VSr3hY3Id1Wj1wzkN743bDtkuXf
         0slg3GmO/PxmCNIsvkt8pL777M8HE7rPHMtwEcsNnNsff99sXmy9Zvx4UKZvArba9N
         M6Ajain0FwMzg==
Date:   Tue, 10 Aug 2021 16:58:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 16/30] iomap: switch iomap_page_mkwrite to use iomap_iter
Message-ID: <20210810235855.GO3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809061244.1196573-17-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 08:12:30AM +0200, Christoph Hellwig wrote:
> Switch iomap_page_mkwrite to use iomap_iter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3a23f7346938fb..5ab464937d4886 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -961,15 +961,15 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  }
>  EXPORT_SYMBOL_GPL(iomap_truncate_page);
>  
> -static loff_t
> -iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
> -		void *data, struct iomap *iomap, struct iomap *srcmap)
> +static loff_t iomap_page_mkwrite_iter(struct iomap_iter *iter,
> +		struct page *page)
>  {
> -	struct page *page = data;
> +	loff_t length = iomap_length(iter);
>  	int ret;
>  
> -	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
> +	if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD) {
> +		ret = __block_write_begin_int(page, iter->pos, length, NULL,
> +					      &iter->iomap);
>  		if (ret)
>  			return ret;
>  		block_commit_write(page, 0, length);
> @@ -983,29 +983,24 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  {
> +	struct iomap_iter iter = {
> +		.inode		= file_inode(vmf->vma->vm_file),
> +		.flags		= IOMAP_WRITE | IOMAP_FAULT,
> +	};
>  	struct page *page = vmf->page;
> -	struct inode *inode = file_inode(vmf->vma->vm_file);
> -	unsigned long length;
> -	loff_t offset;
>  	ssize_t ret;
>  
>  	lock_page(page);
> -	ret = page_mkwrite_check_truncate(page, inode);
> +	ret = page_mkwrite_check_truncate(page, iter.inode);
>  	if (ret < 0)
>  		goto out_unlock;
> -	length = ret;
> -
> -	offset = page_offset(page);
> -	while (length > 0) {
> -		ret = iomap_apply(inode, offset, length,
> -				IOMAP_WRITE | IOMAP_FAULT, ops, page,
> -				iomap_page_mkwrite_actor);
> -		if (unlikely(ret <= 0))
> -			goto out_unlock;
> -		offset += ret;
> -		length -= ret;
> -	}
> +	iter.pos = page_offset(page);
> +	iter.len = ret;
> +	while ((ret = iomap_iter(&iter, ops)) > 0)
> +		iter.processed = iomap_page_mkwrite_iter(&iter, page);
>  
> +	if (ret < 0)
> +		goto out_unlock;
>  	wait_for_stable_page(page);
>  	return VM_FAULT_LOCKED;
>  out_unlock:
> -- 
> 2.30.2
> 
