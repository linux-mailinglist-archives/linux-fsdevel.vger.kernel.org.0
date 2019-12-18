Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0664812471C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 13:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLRMnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 07:43:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:37708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfLRMns (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:43:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E329B175;
        Wed, 18 Dec 2019 12:43:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D99C21E0B2D; Wed, 18 Dec 2019 13:43:46 +0100 (CET)
Date:   Wed, 18 Dec 2019 13:43:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fs: Fix overflow in block_page_mkwrite
Message-ID: <20191218124346.GC19387@quack2.suse.cz>
References: <20191106190239.20860-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106190239.20860-1-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 06-11-19 20:02:39, Andreas Gruenbacher wrote:
> On architectures where ssize_t is wider than pgoff_t, the expression
> ((page->index + 1) << PAGE_SHIFT) can overflow.  Rewrite to use the page
> offset, which we already compute here anyway.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

This patch seems to have fallen through the cracks? Al?

								Honza

> ---
>  fs/buffer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 86a38b979323..da3f33b70249 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2459,21 +2459,21 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>  	struct page *page = vmf->page;
>  	struct inode *inode = file_inode(vma->vm_file);
>  	unsigned long end;
> -	loff_t size;
> +	loff_t offset, size;
>  	int ret;
>  
>  	lock_page(page);
>  	size = i_size_read(inode);
> -	if ((page->mapping != inode->i_mapping) ||
> -	    (page_offset(page) > size)) {
> +	offset = page_offset(page);
> +	if (page->mapping != inode->i_mapping || offset > size) {
>  		/* We overload EFAULT to mean page got truncated */
>  		ret = -EFAULT;
>  		goto out_unlock;
>  	}
>  
>  	/* page is wholly or partially inside EOF */
> -	if (((page->index + 1) << PAGE_SHIFT) > size)
> -		end = size & ~PAGE_MASK;
> +	if (offset > size - PAGE_SIZE)
> +		end = offset_in_page(size);
>  	else
>  		end = PAGE_SIZE;
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
