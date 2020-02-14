Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE6815DA5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 16:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgBNPLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 10:11:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:51764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgBNPLh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:11:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 945B2AE2C;
        Fri, 14 Feb 2020 15:11:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D3C961E0B38; Fri, 14 Feb 2020 16:11:33 +0100 (CET)
Date:   Fri, 14 Feb 2020 16:11:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/7] fs: Un-inline page_mkwrite_check_truncate
Message-ID: <20200214151133.GB22815@quack2.suse.cz>
References: <20200213202423.23455-1-agruenba@redhat.com>
 <20200213202423.23455-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213202423.23455-2-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-02-20 21:24:17, Andreas Gruenbacher wrote:
> Per review comments from Jan and Ted, un-inline page_mkwrite_check_truncate
> and move it to mm/filemap.c.  This function doesn't seem worth inlining.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Theodore Y. Ts'o <tytso@mit.edu>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ccb14b6a16b5..6c9c5b88924d 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -636,32 +636,6 @@ static inline unsigned long dir_pages(struct inode *inode)
>  			       PAGE_SHIFT;
>  }
>  
> -/**
> - * page_mkwrite_check_truncate - check if page was truncated
> - * @page: the page to check
> - * @inode: the inode to check the page against
> - *
> - * Returns the number of bytes in the page up to EOF,
> - * or -EFAULT if the page was truncated.
> - */
> -static inline int page_mkwrite_check_truncate(struct page *page,
> -					      struct inode *inode)
> -{
> -	loff_t size = i_size_read(inode);
> -	pgoff_t index = size >> PAGE_SHIFT;
> -	int offset = offset_in_page(size);
> -
> -	if (page->mapping != inode->i_mapping)
> -		return -EFAULT;
> -
> -	/* page is wholly inside EOF */
> -	if (page->index < index)
> -		return PAGE_SIZE;
> -	/* page is wholly past EOF */
> -	if (page->index > index || !offset)
> -		return -EFAULT;
> -	/* page is partially inside EOF */
> -	return offset;
> -}
> +int page_mkwrite_check_truncate(struct page *page, struct inode *inode);
>  
>  #endif /* _LINUX_PAGEMAP_H */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1784478270e1..edcb4a8a6121 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2678,6 +2678,34 @@ const struct vm_operations_struct generic_file_vm_ops = {
>  	.page_mkwrite	= filemap_page_mkwrite,
>  };
>  
> +/**
> + * page_mkwrite_check_truncate - check if page was truncated
> + * @page: the page to check
> + * @inode: the inode to check the page against
> + *
> + * Returns the number of bytes in the page up to EOF,
> + * or -EFAULT if the page was truncated.
> + */
> +int page_mkwrite_check_truncate(struct page *page, struct inode *inode)
> +{
> +	loff_t size = i_size_read(inode);
> +	pgoff_t index = size >> PAGE_SHIFT;
> +	int offset = offset_in_page(size);
> +
> +	if (page->mapping != inode->i_mapping)
> +		return -EFAULT;
> +
> +	/* page is wholly inside EOF */
> +	if (page->index < index)
> +		return PAGE_SIZE;
> +	/* page is wholly past EOF */
> +	if (page->index > index || !offset)
> +		return -EFAULT;
> +	/* page is partially inside EOF */
> +	return offset;
> +}
> +EXPORT_SYMBOL(page_mkwrite_check_truncate);
> +
>  /* This is used for a general mmap of a disk file */
>  
>  int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
