Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26208855F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 00:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfHGWkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 18:40:01 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52686 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388133AbfHGWkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:40:01 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0B4A0361C58;
        Thu,  8 Aug 2019 08:39:57 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hvUa2-00067h-MZ; Thu, 08 Aug 2019 08:38:50 +1000
Date:   Thu, 8 Aug 2019 08:38:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     viro@zeniv.linux.org.uk, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190807223850.GQ7777@dread.disaster.area>
References: <20190807145114.GP7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807145114.GP7138@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=UD9wB-r_hoJu2ZtOc3wA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 07:51:14AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> +/*
> + * Lock two pages, ensuring that we lock in offset order if the pages are from
> + * the same file.
> + */
> +static void vfs_lock_two_pages(struct page *page1, struct page *page2)
> +{
> +	if (page1 == page2) {
> +		lock_page(page1);
> +		return;
> +	}
> +
> +	if (page1->mapping == page2->mapping && page1->index > page2->index)
> +		swap(page1, page2);

I would do this even if the pages are on different mappings. That
way we don't expose a landmine if some other code locks two pages
from the same mappings in a different order...

> +	lock_page(page1);
> +	lock_page(page2);
> +}
> +
>  /*
>   * Compare extents of two files to see if they are the same.
>   * Caller must have locked both inodes to prevent write races.
> @@ -1867,10 +1881,12 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		dest_page = vfs_dedupe_get_page(dest, destoff);
>  		if (IS_ERR(dest_page)) {
>  			error = PTR_ERR(dest_page);
> -			unlock_page(src_page);
>  			put_page(src_page);
>  			goto out_error;
>  		}
> +
> +		vfs_lock_two_pages(src_page, dest_page);
> +
>  		src_addr = kmap_atomic(src_page);
>  		dest_addr = kmap_atomic(dest_page);
>  
> @@ -1882,7 +1898,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  
>  		kunmap_atomic(dest_addr);
>  		kunmap_atomic(src_addr);
> -		unlock_page(dest_page);
> +		if (dest_page != src_page)
> +			unlock_page(dest_page);
>  		unlock_page(src_page);

Would it make sense for symmetry to wrap these in
vfs_unlock_two_pages()?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
