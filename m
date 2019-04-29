Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02593EC34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfD2Vom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 17:44:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:53036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729341AbfD2Vom (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:44:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DB26ABD7;
        Mon, 29 Apr 2019 21:44:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 932171E3BEC; Mon, 29 Apr 2019 23:44:40 +0200 (CEST)
Date:   Mon, 29 Apr 2019 23:44:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        Edwin =?iso-8859-1?B?VPZy9ms=?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 1/4] iomap: Clean up __generic_write_end calling
Message-ID: <20190429214440.GE1424@quack2.suse.cz>
References: <20190429163239.4874-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429163239.4874-1-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 29-04-19 18:32:36, Andreas Gruenbacher wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Move the call to __generic_write_end into iomap_write_end instead of
> duplicating it in each of the three branches.  This requires open coding
> the generic_write_end for the buffer_head case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 97cb9d486a7d..2344c662e6fc 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -738,13 +738,11 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	 * uptodate page as a zero-length write, and force the caller to redo
>  	 * the whole thing.
>  	 */
> -	if (unlikely(copied < len && !PageUptodate(page))) {
> -		copied = 0;
> -	} else {
> -		iomap_set_range_uptodate(page, offset_in_page(pos), len);
> -		iomap_set_page_dirty(page);
> -	}
> -	return __generic_write_end(inode, pos, copied, page);
> +	if (unlikely(copied < len && !PageUptodate(page)))
> +		return 0;
> +	iomap_set_range_uptodate(page, offset_in_page(pos), len);
> +	iomap_set_page_dirty(page);
> +	return copied;
>  }
>  
>  static int
> @@ -761,7 +759,6 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
>  	kunmap_atomic(addr);
>  
>  	mark_inode_dirty(inode);
> -	__generic_write_end(inode, pos, copied, page);
>  	return copied;
>  }
>  
> @@ -774,12 +771,13 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	if (iomap->type == IOMAP_INLINE) {
>  		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
>  	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = generic_write_end(NULL, inode->i_mapping, pos, len,
> -				copied, page, NULL);
> +		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
> +				page, NULL);
>  	} else {
>  		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
>  	}
>  
> +	ret = __generic_write_end(inode, pos, ret, page);
>  	if (iomap->page_done)
>  		iomap->page_done(inode, pos, copied, page, iomap);
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
