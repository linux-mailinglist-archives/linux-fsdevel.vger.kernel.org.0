Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2D161020
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 11:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgBQKdG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 05:33:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:55782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbgBQKdG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:33:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4055EAF2D;
        Mon, 17 Feb 2020 10:33:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3D5D81E0D47; Mon, 17 Feb 2020 11:33:01 +0100 (CET)
Date:   Mon, 17 Feb 2020 11:33:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] fs: Un-inline page_mkwrite_check_truncate
Message-ID: <20200217103301.GE12032@quack2.suse.cz>
References: <20200213202423.23455-1-agruenba@redhat.com>
 <20200213202423.23455-2-agruenba@redhat.com>
 <20200214201020.52527-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214201020.52527-1-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-02-20 21:10:20, Andreas Gruenbacher wrote:
> Per review comments from Jan and Ted, un-inline page_mkwrite_check_truncate
> and move it to mm/filemap.c.  This function doesn't seem worth inlining.
> 
> v2: Define page_mkwrite_check_truncate outside the CONFIG_MMU guard in
> mm/filemap.c to allow block_page_mkwrite to use this helper on
> ARCH=m68k.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Theodore Y. Ts'o <tytso@mit.edu>

Still looks good to me :). You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagemap.h | 28 +---------------------------
>  mm/filemap.c            | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 27 deletions(-)
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
> index 1784478270e1..eac4f7e84823 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2305,6 +2305,34 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  }
>  EXPORT_SYMBOL(generic_file_read_iter);
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
>  #ifdef CONFIG_MMU
>  #define MMAP_LOTSAMISS  (100)
>  /*
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
