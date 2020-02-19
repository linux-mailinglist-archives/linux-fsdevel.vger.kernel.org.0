Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A98163B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgBSD3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:29:07 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:56365 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726667AbgBSD3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:29:07 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C4ADA7EB4FD;
        Wed, 19 Feb 2020 14:29:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4G2m-0005Wz-JP; Wed, 19 Feb 2020 14:29:00 +1100
Date:   Wed, 19 Feb 2020 14:29:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
Message-ID: <20200219032900.GE10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-31-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=D_ITGRzz0ucxF3CW0B0A:9
        a=m4Eakf-3O-CBJR1D:21 a=uIsSIQHDIO17Gszz:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:46:11AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By putting the 'have we reached the end of the page' condition at the end
> of the loop instead of the beginning, we can remove the 'submit the last
> page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> didn't return 0, which would lead to an endless loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index cb3511eb152a..44303f370b2d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -400,15 +400,9 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
> -	loff_t done, ret;
> +	loff_t ret, done = 0;
>  
> -	for (done = 0; done < length; done += ret) {
> -		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
> -			if (!ctx->cur_page_in_bio)
> -				unlock_page(ctx->cur_page);
> -			put_page(ctx->cur_page);
> -			ctx->cur_page = NULL;
> -		}
> +	while (done < length) {
>  		if (!ctx->cur_page) {
>  			ctx->cur_page = iomap_next_page(inode, ctx->pages,
>  					pos, length, &done);
> @@ -418,6 +412,15 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  		}
>  		ret = iomap_readpage_actor(inode, pos + done, length - done,
>  				ctx, iomap, srcmap);
> +		if (WARN_ON(ret == 0))
> +			break;

This error case now leaks ctx->cur_page....

> +		done += ret;
> +		if (offset_in_page(pos + done) == 0) {
> +			if (!ctx->cur_page_in_bio)
> +				unlock_page(ctx->cur_page);
> +			put_page(ctx->cur_page);
> +			ctx->cur_page = NULL;
> +		}
>  	}
>  
>  	return done;
> @@ -451,11 +454,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  done:
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
> -	if (ctx.cur_page) {
> -		if (!ctx.cur_page_in_bio)
> -			unlock_page(ctx.cur_page);
> -		put_page(ctx.cur_page);
> -	}
> +	BUG_ON(ctx.cur_page);

And so will now trigger both a warn and a bug....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
