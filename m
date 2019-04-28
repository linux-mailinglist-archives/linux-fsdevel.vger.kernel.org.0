Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991A7E175
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 13:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfD2Ljw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 07:39:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727868AbfD2Ljw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:39:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EE20AE20;
        Mon, 29 Apr 2019 11:39:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 820AF1E3BF3; Sun, 28 Apr 2019 21:20:29 +0200 (CEST)
Date:   Sun, 28 Apr 2019 21:20:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/3] iomap: Fix use-after-free error in page_done
 callback
Message-ID: <20190428192029.GB7441@quack2>
References: <20190426131127.19164-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426131127.19164-1-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-04-19 15:11:25, Andreas Gruenbacher wrote:
> In iomap_write_end, we are not holding a page reference anymore when
> calling the page_done callback, but the callback needs that reference to
> access the page.
> 
> To fix that, move the put_page call in __generic_write_end into the
> callers of __generic_write_end.  Then, in iomap_write_end, put the page
> after calling the page_done callback.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Fixes: 63899c6f8851 ("iomap: add a page_done callback")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c |  5 +++--
>  fs/iomap.c  | 12 ++++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ce357602f471..6e2c95160ce3 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2104,7 +2104,6 @@ int __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
>  	}
>  
>  	unlock_page(page);
> -	put_page(page);
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(inode, old_size, pos);
> @@ -2160,7 +2159,9 @@ int generic_write_end(struct file *file, struct address_space *mapping,
>  			struct page *page, void *fsdata)
>  {
>  	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
> -	return __generic_write_end(mapping->host, pos, copied, page);
> +	copied = __generic_write_end(mapping->host, pos, copied, page);
> +	put_page(page);
> +	return copied;
>  }
>  EXPORT_SYMBOL(generic_write_end);
>  
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 97cb9d486a7d..3e4652dac9d9 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -765,6 +765,14 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
>  	return copied;
>  }
>  
> +static int
> +buffer_write_end(struct address_space *mapping, loff_t pos, loff_t len,
> +		unsigned copied, struct page *page)
> +{
> +	copied = block_write_end(NULL, mapping, pos, len, copied, page, NULL);
> +	return __generic_write_end(mapping->host, pos, copied, page);
> +}
> +
>  static int
>  iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  		unsigned copied, struct page *page, struct iomap *iomap)
> @@ -774,14 +782,14 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	if (iomap->type == IOMAP_INLINE) {
>  		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
>  	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = generic_write_end(NULL, inode->i_mapping, pos, len,
> -				copied, page, NULL);
> +		ret = buffer_write_end(inode->i_mapping, pos, len, copied, page);
>  	} else {
>  		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
>  	}
>  
>  	if (iomap->page_done)
>  		iomap->page_done(inode, pos, copied, page, iomap);
> +	put_page(page);
>  
>  	if (ret < len)
>  		iomap_write_failed(inode, pos, len);
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
