Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C4163AF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 04:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgBSDRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 22:17:20 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10027 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgBSDRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:17:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4ca89f0000>; Tue, 18 Feb 2020 19:16:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Feb 2020 19:17:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 19:17:19 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Feb
 2020 03:17:19 +0000
Subject: Re: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d4803ef9-7a2f-965f-8f0f-c5e15396d892@nvidia.com>
Date:   Tue, 18 Feb 2020 19:17:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-31-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582082207; bh=qudh4G4mbAakXyxDC+CEEfYfnwTeUkkYc+c7DnUQ5iw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YslRlare92/3kKy2ALdiRw0V4leVlhB+OQ2oTCia+X/cOeEhILWlZgjniE6GIN3l+
         GrCYIb7qY2r0mt7gmyLFsOrUF1a+I4fEnIhLtzNfT8q1GKHB5igJo/82WfvUBj7rDW
         UFJv/dlLBUbcosBLSj9TopeTp6oClzjJ1Kpb+8b1fSY0G1eCISE4bKDBcJJtMMI1CT
         4iBbTKL2IhwyI9qcJsmvCTSjJGJxxS/r9E9pcv0+56/p+lZW3IkcA9kTY2BrcqBJ0d
         NZhpcuPzYZ+mrkj414zWNzMsUZRQBdbFd4hBeNlv1s5LJX19bnMStWaOU3ItxgSXyZ
         89tOyTLlKSRuQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/20 10:46 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By putting the 'have we reached the end of the page' condition at the end
> of the loop instead of the beginning, we can remove the 'submit the last
> page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> didn't return 0, which would lead to an endless loop.


Also added a new WARN_ON() and BUG(), although I'm wondering about the BUG
below...


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


nit: this "for" loop was perfect just the way it was. :) I'd vote here for reverting
the change to a "while" loop. Because with this change, now the code has to 
separately initialize "done", separately increment "done", and the beauty of a
for loop is that the loop init and control is all clearly in one place. For things
that follow that model (as in this case!), that's a Good Thing.

And I don't see any technical reason (even in the following patch) that requires 
this change.


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


Is a full BUG_ON() definitely called for here? Seems like a WARN might suffice...


>  
>  	/*
>  	 * Check that we didn't lose a page due to the arcance calling
> 



thanks,
-- 
John Hubbard
NVIDIA
