Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658F9EC2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfD2Vlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 17:41:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:52546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729252AbfD2Vlg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:41:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96A6EABD7;
        Mon, 29 Apr 2019 21:41:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9167F1E3BEC; Mon, 29 Apr 2019 23:41:32 +0200 (CEST)
Date:   Mon, 29 Apr 2019 23:41:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 3/4] iomap: Add a page_prepare callback
Message-ID: <20190429214132.GD1424@quack2.suse.cz>
References: <20190429163239.4874-1-agruenba@redhat.com>
 <20190429163239.4874-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429163239.4874-3-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 29-04-19 18:32:38, Andreas Gruenbacher wrote:
> Move the page_done callback into a separate iomap_page_ops structure and
> add a page_prepare calback to be called before the next page is written
> to.  In gfs2, we'll want to start a transaction in page_prepare and end
> it in page_done.  Other filesystems that implement data journaling will
> require the same kind of mechanism.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/bmap.c        | 22 +++++++++++++++++-----
>  fs/iomap.c            | 36 ++++++++++++++++++++++++++----------
>  include/linux/iomap.h | 22 +++++++++++++++++-----
>  3 files changed, 60 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 5da4ca9041c0..6b980703bae7 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -991,15 +991,27 @@ static void gfs2_write_unlock(struct inode *inode)
>  	gfs2_glock_dq_uninit(&ip->i_gh);
>  }
>  
> -static void gfs2_iomap_journaled_page_done(struct inode *inode, loff_t pos,
> -				unsigned copied, struct page *page,
> -				struct iomap *iomap)
> +static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
> +				   unsigned len, struct iomap *iomap)
> +{
> +	return 0;
> +}
> +
> +static void gfs2_iomap_page_done(struct inode *inode, loff_t pos,
> +				 unsigned copied, struct page *page,
> +				 struct iomap *iomap)
>  {
>  	struct gfs2_inode *ip = GFS2_I(inode);
>  
> -	gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
> +	if (page)
> +		gfs2_page_add_databufs(ip, page, offset_in_page(pos), copied);
>  }
>  
> +static const struct iomap_page_ops gfs2_iomap_page_ops = {
> +	.page_prepare = gfs2_iomap_page_prepare,
> +	.page_done = gfs2_iomap_page_done,
> +};
> +
>  static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
>  				  loff_t length, unsigned flags,
>  				  struct iomap *iomap,
> @@ -1077,7 +1089,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
>  		}
>  	}
>  	if (!gfs2_is_stuffed(ip) && gfs2_is_jdata(ip))
> -		iomap->page_done = gfs2_iomap_journaled_page_done;
> +		iomap->page_ops = &gfs2_iomap_page_ops;
>  	return 0;
>  
>  out_trans_end:
> diff --git a/fs/iomap.c b/fs/iomap.c
> index b01ed5a28d2c..ee9ce7a06244 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -665,6 +665,7 @@ static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		struct page **pagep, struct iomap *iomap)
>  {
> +	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	pgoff_t index = pos >> PAGE_SHIFT;
>  	struct page *page;
>  	int status = 0;
> @@ -674,9 +675,17 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
>  
> +	if (page_ops && page_ops->page_prepare) {
> +		status = page_ops->page_prepare(inode, pos, len, iomap);
> +		if (status)
> +			return status;
> +	}
> +
>  	page = grab_cache_page_write_begin(inode->i_mapping, index, flags);
> -	if (!page)
> -		return -ENOMEM;
> +	if (!page) {
> +		status = -ENOMEM;
> +		goto out_no_page;
> +	}
>  
>  	if (iomap->type == IOMAP_INLINE)
>  		iomap_read_inline_data(inode, page, iomap);
> @@ -684,15 +693,21 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
>  	else
>  		status = __iomap_write_begin(inode, pos, len, page, iomap);
> -	if (unlikely(status)) {
> -		unlock_page(page);
> -		put_page(page);
> -		page = NULL;
>  
> -		iomap_write_failed(inode, pos, len);
> -	}
> +	if (unlikely(status))
> +		goto out_unlock;
>  
>  	*pagep = page;
> +	return 0;
> +
> +out_unlock:
> +	unlock_page(page);
> +	put_page(page);
> +	iomap_write_failed(inode, pos, len);
> +
> +out_no_page:
> +	if (page_ops && page_ops->page_done)
> +		page_ops->page_done(inode, pos, 0, NULL, iomap);
>  	return status;
>  }
>  
> @@ -766,6 +781,7 @@ static int
>  iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  		unsigned copied, struct page *page, struct iomap *iomap)
>  {
> +	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	int ret;
>  
>  	if (iomap->type == IOMAP_INLINE) {
> @@ -778,8 +794,8 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	}
>  
>  	ret = __generic_write_end(inode, pos, ret, page);
> -	if (iomap->page_done)
> -		iomap->page_done(inode, pos, copied, page, iomap);
> +	if (page_ops)
> +		page_ops->page_done(inode, pos, copied, page, iomap);
>  	put_page(page);
>  
>  	if (ret < len)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 0fefb5455bda..2103b94cb1bf 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -53,6 +53,8 @@ struct vm_fault;
>   */
>  #define IOMAP_NULL_ADDR -1ULL	/* addr is not valid */
>  
> +struct iomap_page_ops;
> +
>  struct iomap {
>  	u64			addr; /* disk offset of mapping, bytes */
>  	loff_t			offset;	/* file offset of mapping, bytes */
> @@ -63,12 +65,22 @@ struct iomap {
>  	struct dax_device	*dax_dev; /* dax_dev for dax operations */
>  	void			*inline_data;
>  	void			*private; /* filesystem private */
> +	const struct iomap_page_ops *page_ops;
> +};
>  
> -	/*
> -	 * Called when finished processing a page in the mapping returned in
> -	 * this iomap.  At least for now this is only supported in the buffered
> -	 * write path.
> -	 */
> +/*
> + * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
> + * and page_done will be called for each page written to.  This only applies to
> + * buffered writes as unbuffered writes will not typically have pages
> + * associated with them.
> + *
> + * When page_prepare succeeds, page_done will always be called to do any
> + * cleanup work necessary.  In that page_done call, @page will be NULL if the
> + * associated page could not be obtained.
> + */
> +struct iomap_page_ops {
> +	int (*page_prepare)(struct inode *inode, loff_t pos, unsigned len,
> +			struct iomap *iomap);
>  	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
>  			struct page *page, struct iomap *iomap);
>  };
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
